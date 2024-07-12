when (compiles do: import karax / karaxdsl):
  import karax / [vdom, karax, karaxdsl ]
else:
  {.error: "Please use `logue extension karax` to install!".}

import std/json
import ../fix_to_json

proc parse() =
  let message = getVNodeById(cstring"fix").getInputText
  getVNodeById(cstring"json").setInputText(cstring(pretty(fix_to_json($(message), false))))

proc clear() =
  getVNodeById(cstring"fix").setInputText("")
  getVNodeById(cstring"json").setInputText("")

proc createDom(): VNode = 
  const
    fix_field = cstring"fix"
    json_field = cstring"json"
    clear_button = "clear"

  result = buildHtml(tdiv(class = "mt-3")):
    tdiv(class = "container"):
      tdiv(class = "column"):
        label(`for` = fix_field):
          text "FIX message"
          textarea(id = fix_field, rows="10")
          button(id = clear_button):
            text "Clear"
            proc onclick = clear()

      tdiv(class = "column"):
        button:
          text "Parse"
          proc onclick = parse()

      tdiv(class = "column"):
        label(`for` = json_field):
          text "JSON version"
          textarea(id = json_field, rows="10")

setRenderer createDom
