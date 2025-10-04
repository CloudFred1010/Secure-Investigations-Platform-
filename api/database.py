from typing import Dict
from datetime import datetime
from api.models import Case  # ✅ fixed import

# Simulated DB (just a dictionary for now)
cases_db: Dict[int, Case] = {}
case_counter = 0


def create_case(title: str, description: str = None) -> Case:
    global case_counter
    case_counter += 1
    now = datetime.utcnow()
    new_case = Case(
        id=case_counter,
        title=title,
        description=description,
        status="open",
        created_at=now,
        updated_at=now,
    )
    cases_db[new_case.id] = new_case
    return new_case
