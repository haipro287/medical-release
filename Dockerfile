FROM supermedicalchain/build-flutter
USER root
RUN rm -Rf /src
WORKDIR /src
COPY . .
RUN chmod -R 777 .
USER developer
RUN flutter build apk --target-platform=android-arm64 --split-per-abi --release
USER root
