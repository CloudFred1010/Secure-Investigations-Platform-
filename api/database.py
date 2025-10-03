from typing import Dict
from .models import Case
from datetime import datetime

# In-memory store for now
cases: Dict[int, Case] = {}
next_id = 1

def create_case(title: str, description: str = "") -> Case:
    global next_id
    case = Case(
        id=next_id,
        title=title,
        description=description,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow()
    )
    cases[next_id] = case
    next_id += 1
    return case

def get_case(case_id: int) -> Case | None:
    return cases.get(case_id)

def list_cases():
    return list(cases.values())

def update_case(case_id: int, title: str, description: str, status: str) -> Case | None:
    case = cases.get(case_id)
    if case:
        case.title = title
        case.description = description
        case.status = status
        case.updated_at = datetime.utcnow()
        cases[case_id] = case
    return case

def delete_case(case_id: int) -> bool:
    return cases.pop(case_id, None) is not None
