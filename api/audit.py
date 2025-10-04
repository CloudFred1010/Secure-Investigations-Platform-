def emit_audit_event(action: str, case_id: int, user=None):
    print(f"[AUDIT] User={user.get('oid') if user else 'anonymous'} "
          f"Action={action} CaseID={case_id}")
