let parseToStringArray = location => location->Node.Fs.readFileAsUtf8Sync->Js.String2.split("\n")

let parseToIntArray = location =>
  location
  ->parseToStringArray
  ->Belt.Array.map(i => Belt.Int.fromString(i))
  ->Belt.Array.map(o => Belt.Option.getExn(o))
