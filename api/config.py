TENANT_ID = "your-tenant-id-here"
CLIENT_ID = "your-api-app-registration-client-id"
AUTHORITY = f"https://login.microsoftonline.com/{TENANT_ID}"
JWKS_URL = f"{AUTHORITY}/discovery/v2.0/keys"
AUDIENCE = CLIENT_ID
