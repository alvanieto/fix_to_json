import json, tables, strutils, utils

proc fix_to_json*(fix_message: string, show = true): JsonNode =
  var
    fields = init_ordered_table[string, string]()
    json_obj = newJObject()

  for field in fix_message.split(chr(1)):
    if field.len > 0:
      let parts = field.split("=", 1)
      if parts.len == 2:
        fields[parts[0]] = parts[1]

  for key, value in fields:
    let key_str = getFieldDescription($key)
    if key_str == "MsgType":
      json_obj[key_str] = %getMessageType($value)
    else:
      json_obj[key_str] = %value

  if show:
    echo json_obj.pretty
  return json_obj
