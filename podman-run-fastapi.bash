podman build --no-cache --rm --file Containerfile --tag fastapi:demo .
podman run --interactive --tty --publish 8000:8000 fastapi:demo
echo "browse http://localhost:8000/"
