FROM node:10.15.0-alpine as builder

WORKDIR /usr/src/app
COPY . /usr/src/app/

RUN mkdir build && cd server && yarn install --frozen-lockfile --production && \
    cp -r . ../build && cd ../client && \
    yarn install --frozen-lockfile && \
    yarn run build && \
    cp -r build ../build/src/public

FROM node:10.15.0-alpine
WORKDIR /usr/share/app/
COPY --from=builder /usr/src/app/build/ /usr/share/app

ENTRYPOINT ["./server.sh"]

EXPOSE 8000
