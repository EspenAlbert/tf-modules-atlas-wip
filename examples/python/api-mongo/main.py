import logging

from fastapi import FastAPI
from fastapi.requests import Request
from pydantic_settings import BaseSettings
from pymongo import MongoClient
from pymongo.errors import ConnectionFailure

logger = logging.getLogger(__name__)

app = FastAPI()


class Settings(BaseSettings):
    mongo_url: str = "mongodb://user:pass@localhost:27017?retryWrites=true&w=majority&authSource=admin"


settings = Settings()


ALL_METHODS = [
    "GET",
    "PUT",
    "POST",
    "DELETE",
    "OPTIONS",
    "HEAD",
    "PATCH",
    "TRACE",
]


@app.api_route("/{path:path}", methods=ALL_METHODS)
def health_check(request: Request, path: str = "") -> dict:
    host = (
        request.headers.get("host")
        or request.headers.get("Host")
        or request.url.hostname
    )
    url = f"{host}{path}" if path else host
    logger.info(f"sample for {url}")
    client = MongoClient(
        settings.mongo_url, serverSelectionTimeoutMS=5000
    )  # Adjust URI as needed
    db_ok = False
    error_msg = ""
    try:
        client.admin.command("ping")
        db_ok = True
    except ConnectionFailure as e:
        error_msg = f"Server not available: {e!r}"
        logger.warning(error_msg)
    except Exception as e:
        error_msg = f"Unexpected error: {e!r}"
        logger.error(error_msg)
    path = (
        request.headers.get("path") or request.headers.get("Path") or request.url.path
    )
    return {"db": db_ok, "error": error_msg}
