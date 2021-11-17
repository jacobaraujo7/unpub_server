FROM google/dart:2.14.4 AS build
WORKDIR /app
COPY . .
RUN dart pub get
RUN dart compile exe ./bin/pub_server_local.dart -o ./server_unpub

FROM subfuzion/dart:slim
WORKDIR /app
COPY --from=build /app/server_unpub ./server_unpub
ENTRYPOINT [ "./server_unpub" ]