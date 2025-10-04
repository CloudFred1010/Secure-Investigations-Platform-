from pydantic import BaseModel
from datetime import datetime
from typing import Optional


class Case(BaseModel):
    id: int
    title: str
    description: Optional[str] = None
    status: str = "open"
    created_at: datetime
    updated_at: datetime


class CaseCreate(BaseModel):
    title: str
    description: Optional[str] = None


class CaseUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    status: Optional[str] = None
