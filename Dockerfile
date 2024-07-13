FROM nimlang/nim

WORKDIR /opt/fix_to_json
COPY . .
RUN nimble install && nim js -d:release src/templates/index.nim && nim c d:release src/server.nim

EXPOSE 8080

CMD ["./src/server"]
