let parseToStringArray = location => location->Node.Fs.readFileAsUtf8Sync->Js.String2.split("\n")

let parseByNewLine = location =>
  location
  ->Node.Fs.readFileAsUtf8Sync
  ->Js.String2.split("\n\n")
  ->Js.Array2.map(x => x->Js.String2.replaceByRe(%re(`/\n/g`), " ")->Js.String2.trim)

let parseToIntArray = location =>
  location
  ->parseToStringArray
  ->Belt.Array.map(i => Belt.Int.fromString(i))
  ->Belt.Array.map(o => Belt.Option.getExn(o))
