FROM ubuntu:22.04 AS build

ENV DEBIAN_FRONTEND=noninteractive
ENV FLUTTER_VERSION=3.47.3
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:$PATH"

RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o flutter.tar.xz \
    https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter.tar.xz -C / \
    && rm flutter.tar.xz

RUN git config --global --add safe.directory /flutter
RUN git config --global --add safe.directory '*'

RUN flutter config --no-analytics
RUN flutter precache --web

WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get
COPY . .
RUN flutter build web --release

FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]