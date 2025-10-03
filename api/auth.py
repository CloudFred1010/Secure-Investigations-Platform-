# auth.py
import os
import httpx
from jose import jwt
from fastapi import HTTPException, Security
from fastapi.security import HTTPBearer
from typing import Dict, Any

# Real Entra ID values (production mode)
TENANT_ID = "952e47c4-05de-4282-83af-5f4b46b1628f"
CLIENT_ID = "c4371459-6fe9-4b12-95a2-5674eef74164"
JWKS_URL = f"https://login.microsoftonline.com/{TENANT_ID}/discovery/v2.0/keys"

security = HTTPBearer()
jwks_cache = None

# Dev overrides (local testing only)
DEV_JWT_SECRET = os.getenv("DEV_JWT_SECRET")  # shared secret for HS256 tokens
DEV_AUTH = os.getenv("DEV_AUTH", "false").lower() in ("1", "true", "yes")


async def get_jwks() -> Dict[str, Any]:
    """Fetch and cache the JSON Web Key Set (JWKS) from Entra ID"""
    global jwks_cache
    if not jwks_cache:
        async with httpx.AsyncClient() as client:
            resp = await client.get(JWKS_URL)
            resp.raise_for_status()
            jwks_cache = resp.json()
    return jwks_cache


async def validate_token(auth=Security(security)) -> Dict[str, Any]:
    """
    Validate incoming JWT:
      - If DEV_AUTH is true and no DEV_JWT_SECRET, bypass and return fake user.
      - If DEV_JWT_SECRET is set, accept HS256 tokens for local dev.
      - Otherwise, validate RS256 tokens from Entra ID via JWKS.
    """
    token = auth.credentials

    # Simple dev bypass (no signature check, returns fake user)
    if DEV_AUTH and not DEV_JWT_SECRET:
        return {
            "sub": "dev-user",
            "name": "Developer (bypass)",
            "roles": ["investigator"]
        }

    # HS256 dev token mode
    if DEV_JWT_SECRET:
        try:
            decoded = jwt.decode(
                token,
                DEV_JWT_SECRET,
                algorithms=["HS256"],
                audience=CLIENT_ID,
            )
            return decoded
        except Exception:
            # fall back to real validation if HS256 decode fails
            pass

    # RS256 Entra ID validation via JWKS
    jwks = await get_jwks()
    try:
        unverified_header = jwt.get_unverified_header(token)
        key = next((k for k in jwks["keys"] if k.get("kid") == unverified_header.get("kid")), None)
        if not key:
            raise HTTPException(status_code=401, detail="Invalid token header")

        decoded = jwt.decode(
            token,
            key,
            algorithms=["RS256"],
            audience=CLIENT_ID,
            options={"verify_aud": True},
        )
        return decoded
    except Exception as e:
        raise HTTPException(status_code=401, detail=f"Token validation failed: {e}")
