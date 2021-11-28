let parse = loc =>
  loc
  ->TextFileParser.parseByNewLine
  ->Js.Array2.map(x => x->Js.String2.split("")->Js.Array2.filter(c => c != " "))

let findUniqueAnswers = group => {
  let unique = ref([])
  let iterations = group->Js.Array2.length - 1

  for i in 0 to iterations {
    let char = group->Belt.Array.get(i)
    switch char {
    | None => ()
    | Some(char) =>
      switch unique.contents {
      | c if c->Js.Array2.includes(char) => ()
      | _ => unique := unique.contents->Js.Array2.concat([char])
      }
    }
  }
  unique.contents
}

let findSumOfUniqueAnswers = groups => {
  groups->Js.Array2.reduce((acc, cur) => {
    acc + cur->findUniqueAnswers->Js.Array2.length
  }, 0)
}
