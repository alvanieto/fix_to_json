FROM nimlang/nim

RUN nim js -d:release src/templates/index.nim && nim c -r src/server.nim

EXPOSE 8080

CMD ["./src/server"]
