FROM liararepo/static-platform:base

COPY default_liara_nginx.conf /etc/nginx/conf.d/liara_nginx.conf

ONBUILD COPY --from=builder /app/dist /usr/share/nginx/html
ONBUILD COPY --from=builder /app/liara_nginx.conf /app/liara_nginx.conf

ONBUILD RUN if cmp /etc/nginx/conf.d/liara_nginx.conf /app/liara_nginx.conf; \
  then \
    echo 'Applying default liara_nginx.conf...'; \
  else \
    echo 'Applying custom liara_nginx.conf...'; \
    mv /app/liara_nginx.conf /etc/nginx/conf.d/liara_nginx.conf; \
fi