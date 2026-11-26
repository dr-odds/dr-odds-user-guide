FROM python:3.13-alpine AS build
WORKDIR /guide
RUN pip install --no-cache-dir mkdocs==1.6.1
COPY README.md docs/README.md
COPY en/ docs/en/
COPY fa/ docs/fa/
COPY media/ docs/media/
RUN printf '%s\n' 'site_name: Dr.odds User Guide' 'use_directory_urls: false' > mkdocs.yml \
    && mkdocs build --strict

FROM nginxinc/nginx-unprivileged:stable-alpine
COPY --from=build /guide/site/ /usr/share/nginx/html/
EXPOSE 8080
