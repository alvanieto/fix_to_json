# Description
Simple nim application to convert a FIX message to json

![sample](sample.png)

Try live server:
<https://fix-to-json.onrender.com/>

To build & run the application:
```bash
nimble build
main
```

To run the server:
```bash
nim js -d:release src/templates/index.nim
nim c -r src/server.nim
```

To run the tests:
```bash
nimble test
```
