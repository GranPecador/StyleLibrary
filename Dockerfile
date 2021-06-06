# FROM openjdk:8-jdk

# # Just matched `app/build.gradle`
# ENV ANDROID_COMPILE_SDK "31"
# # Just matched `app/build.gradle`
# ENV ANDROID_BUILD_TOOLS "31.0.2"
# # Version from https://developer.android.com/studio/releases/sdk-tools
# ENV ANDROID_SDK_TOOLS "31.0.2"

# ENV ANDROID_HOME /android-sdk-linux
# ENV PATH="${PATH}:/android-sdk-linux/platform-tools/"
# ENV JAVA_HOME=/usr/local/openjdk-8
# ENV PATH=$PATH:/usr/local/openjdk-8/bin/java
# # install OS packages
# RUN apt-get --quiet update --yes
# RUN apt-get --quiet install --yes wget apt-utils tar unzip lib32stdc++6 lib32z1 build-essential ruby ruby-dev
# # We use this for xxd hex->binary
# RUN apt-get --quiet install --yes vim-common
# # install Android SDK
# RUN wget --quiet --output-document=android-sdk.tgz https://dl.google.com/android/repository/platform-tools_r{ANDROID_SDK_TOOLS}-linux.zip
# https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz
# RUN tar --extract --gzip --file=android-sdk.tgz
# RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_COMPILE_SDK}
# RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools
# RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS}
# RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository
# RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services
# RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository



# FROM ubuntu:18.04

# ENV DEBIAN_FRONTEND noninteractive

# ENV ANDROID_HOME      /opt/android-sdk-linux
# ENV ANDROID_SDK_HOME  ${ANDROID_HOME}
# ENV ANDROID_SDK_ROOT  ${ANDROID_HOME}
# ENV ANDROID_SDK       ${ANDROID_HOME}

# ENV PATH "${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
# ENV PATH "${PATH}:${ANDROID_HOME}/cmdline-tools/tools/bin"
# ENV PATH "${PATH}:${ANDROID_HOME}/tools/bin"
# ENV PATH "${PATH}:${ANDROID_HOME}/build-tools/30.0.2"
# ENV PATH "${PATH}:${ANDROID_HOME}/platform-tools"
# ENV PATH "${PATH}:${ANDROID_HOME}/emulator"
# ENV PATH "${PATH}:${ANDROID_HOME}/bin"

# RUN dpkg --add-architecture i386 && \
#     apt-get update -yqq && \
#     apt-get install -y curl expect git libc6:i386 libgcc1:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 openjdk-11-jdk wget unzip vim && \
#     apt-get clean

# RUN groupadd android && useradd -d /opt/android-sdk-linux -g android android

# COPY tools /opt/tools
# COPY licenses /opt/licenses

# WORKDIR /opt/android-sdk-linux

# RUN /opt/tools/entrypoint.sh built-in

# RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "cmdline-tools;latest"
# RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "build-tools;30.0.2"
# RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "platform-tools"
# RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "platforms;android-30"
# RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "system-images;android-30;google_apis;x86_64"

# CMD /opt/tools/entrypoint.sh built-in



FROM openjdk:8-jdk

# Just matched `app/build.gradle`
ENV ANDROID_COMPILE_SDK "28"
# Just matched `app/build.gradle`
ENV ANDROID_BUILD_TOOLS "28.0.2"
# Version from https://developer.android.com/studio/releases/sdk-tools
ENV ANDROID_SDK_TOOLS "4333796"

ENV ANDROID_HOME /android-sdk-linux
ENV PATH="${PATH}:/android-sdk-linux/platform-tools/"
ENV JAVA_HOME=/usr/local/openjdk-8
ENV PATH=$PATH:/usr/local/openjdk-8/bin/java
# install OS packages
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
# We use this for xxd hex->binary
RUN apt-get --quiet install --yes vim-common
# install Android SDK
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
# https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz
RUN unzip -d android-sdk-linux android-sdk.zip
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
ENV ANDROID_HOME=$PWD/android-sdk-linux
ENV PATH=$PATH:$PWD/android-sdk-linux/platform-tools/
# RUN chmod +x ./gradlew
# RUN set +o pipefail
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses
# RUN set -o pipefail
