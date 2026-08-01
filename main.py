import sys
import fastapi
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root(name: str = None):
  message = f"Hello {name}!" if name else "Hello World!"
  return {
    "message": message,
    "python_version": sys.version,
    "fastapi_version": fastapi.__version__
  }
