FROM supermedicalchain/build-flutter
USER root
RUN rm -Rf /src
WORKDIR /src
COPY . .
RUN chmod -R 777 .
USER developer
ARG BUILD_NAME
RUN flutter build apk --target-platform=android-arm64 --split-per-abi --release --build-name=${BUILD_NAME}
USER root
