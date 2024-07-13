FROM nimlang/nim

WORKDIR /opt/fix_to_json

COPY ./src/server .
COPY ./src/templates .

CMD ["server"]
