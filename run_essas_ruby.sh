podman podman container rm -fa
podman build -t essas_ruby:1.0 .
podman run --rm -d -p 3000:3000 -e PORT=3000 localhost/essas_ruby:1.0
