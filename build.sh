docker build -t vue-platform:builder -f Dockerfile.builder .
docker build -t vue-platform:nginx -f Dockerfile.nginx .