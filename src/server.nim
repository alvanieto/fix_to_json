import prologue
import prologue/middlewares/staticfile

proc main*(ctx: Context) {.async.} = 
  resp readFile("src/templates/index.html")

let settings = newSettings(debug = true)
var app = newApp(settings)
app.use(staticFileMiddleware("src/templates"))
app.addRoute("/", main)
app.run()
