import os
import fix_to_json


proc main() =
  let args = commandLineParams()

  if args.len == 0:
    echo "Usage: fix_to_json FixMessage"
  else:
    discard fix_to_json(args[0])

main()
