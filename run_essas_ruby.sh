podman build -t essas_ruby:1.0 .
podman run --rm -d -p 3000:3000 essas_ruby:1.0
