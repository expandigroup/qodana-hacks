ARG IMAGE
FROM $IMAGE
RUN mv /opt/idea/bin/qodana /opt/idea/bin/qodana.orig
COPY entrypoint.sh /opt/idea/bin/qodana
ENTRYPOINT ["/entrypoint.sh"]
