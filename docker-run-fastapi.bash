docker build --no-cache --rm -f Containerfile -t fastapi:demo .
docker run --interactive --tty -p 8000:8000 fastapi:demo
echo "browse http://localhost:8000/"
