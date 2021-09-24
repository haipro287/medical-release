FROM ubuntu:18.04
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
ENV PATH "$PATH:/home/developer/flutter/bin"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"
USER root
WORKDIR /home/developer
COPY --from=supermedicalchain/build-flutter /home/developer/Android /home/developer/Android
RUN chmod -R 777 /home/developer/Android
COPY --from=supermedicalchain/build-flutter /home/developer/.android /home/developer/.android
RUN chmod -R 777 /home/developer/.android
COPY --from=supermedicalchain/build-flutter /home/developer/.gradle /home/developer/.gradle
RUN chmod -R 777 /home/developer/.gradle
COPY --from=supermedicalchain/build-flutter /home/developer/.pub-cache  /home/developer/.pub-cache
RUN chmod -R 777 /home/developer/.pub-cache
COPY --from=supermedicalchain/build-flutter /home/developer/flutter /home/developer/flutter
RUN chmod -R 777 /home/developer/flutter

RUN rm -Rf /src
WORKDIR /src
COPY . .
RUN chmod -R 777 . 
USER developer
ARG BUILD_NAME
RUN flutter build apk --target-platform=android-arm64 --split-per-abi --release --build-name=${BUILD_NAME}
USER root
