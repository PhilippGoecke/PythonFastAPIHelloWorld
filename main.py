from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root(name: str = None):
  message = f"Hello {name}!" if name else "Hello World!"
  return {"message": message}
