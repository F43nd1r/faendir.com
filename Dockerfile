FROM busybox:stable
COPY public/ /srv/
EXPOSE 9753
USER 10001:10001
ENTRYPOINT ["httpd", "-f", "-p", "9753", "-h", "/srv"]