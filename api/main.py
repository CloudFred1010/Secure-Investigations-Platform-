from fastapi import FastAPI, HTTPException, Depends
from typing import List
from datetime import datetime

# Use package-relative imports
from api.models import Case, CaseCreate, CaseUpdate
from api.database import cases_db, create_case
from api.audit import emit_audit_event
from api.auth import validate_token  # only Entra validation now

app = FastAPI(title="Investigations API")

# -------------------------
# Root & Health Endpoints
# -------------------------

@app.get("/")
def read_root():
    return {"message": "Welcome to the Investigations API"}

@app.get("/healthz")
def health_check():
    return {"status": "ok", "timestamp": datetime.utcnow()}

# -------------------------
# Case Endpoints (CRUD)
# -------------------------

@app.post("/cases", response_model=Case)
def create_case_endpoint(
    case: CaseCreate,
    user=Depends(validate_token)   # Require valid Entra JWT
):
    new_case = create_case(title=case.title, description=case.description)
    emit_audit_event("CREATE", new_case.id, user=user)
    return new_case

@app.get("/cases", response_model=List[Case])
def list_cases(user=Depends(validate_token)):
    return list(cases_db.values())

@app.get("/cases/{case_id}", response_model=Case)
def get_case(case_id: int, user=Depends(validate_token)):
    case = cases_db.get(case_id)
    if not case:
        raise HTTPException(status_code=404, detail="Case not found")
    return case

@app.put("/cases/{case_id}", response_model=Case)
def update_case(case_id: int, case_update: CaseUpdate, user=Depends(validate_token)):
    case = cases_db.get(case_id)
    if not case:
        raise HTTPException(status_code=404, detail="Case not found")

    update_data = case.dict()
    if case_update.title is not None:
        update_data["title"] = case_update.title
    if case_update.description is not None:
        update_data["description"] = case_update.description
    if case_update.status is not None:
        update_data["status"] = case_update.status

    update_data["updated_at"] = datetime.utcnow()
    updated_case = Case(**update_data)
    cases_db[case_id] = updated_case

    emit_audit_event("UPDATE", case_id, user=user)
    return updated_case

@app.delete("/cases/{case_id}")
def delete_case(case_id: int, user=Depends(validate_token)):
    if case_id not in cases_db:
        raise HTTPException(status_code=404, detail="Case not found")
    del cases_db[case_id]
    emit_audit_event("DELETE", case_id, user=user)
    return {"ok": True}
