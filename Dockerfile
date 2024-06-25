ARG IMAGE
FROM $IMAGE
COPY entrypoint.sh /entrypoint.sh
RUN QODANA=$(which qodana) && mv "$QODANA" "${QODANA}.orig" && mv /entrypoint.sh "$QODANA"
