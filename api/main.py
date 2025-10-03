from fastapi import FastAPI, HTTPException
from . import database, audit
from .models import Case

app = FastAPI(title="Investigations Portal API")

@app.post("/cases", response_model=Case)
def create_case(title: str, description: str = ""):
    case = database.create_case(title, description)
    audit.emit_audit_event("CREATE", case.id)
    return case

@app.get("/cases", response_model=list[Case])
def list_all_cases():
    return database.list_cases()

@app.get("/cases/{case_id}", response_model=Case)
def get_case(case_id: int):
    case = database.get_case(case_id)
    if not case:
        raise HTTPException(status_code=404, detail="Case not found")
    return case

@app.put("/cases/{case_id}", response_model=Case)
def update_case(case_id: int, title: str, description: str, status: str):
    case = database.update_case(case_id, title, description, status)
    if not case:
        raise HTTPException(status_code=404, detail="Case not found")
    audit.emit_audit_event("UPDATE", case_id)
    return case

@app.delete("/cases/{case_id}")
def delete_case(case_id: int):
    success = database.delete_case(case_id)
    if not success:
        raise HTTPException(status_code=404, detail="Case not found")
    audit.emit_audit_event("DELETE", case_id)
    return {"deleted": True}
