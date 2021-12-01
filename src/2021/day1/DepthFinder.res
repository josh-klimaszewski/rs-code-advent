let parse = loc => loc->TextFileParser.parseToStringArray->Js.Array2.map(int_of_string)

let findDepthChange = entries => {
  let change = ref(0)
  for i in 0 to entries->Js.Array2.length - 1 {
    switch i {
    | 0 => ()
    | _ =>
      switch entries[i] > entries[i - 1] {
      | true => change := change.contents + 1
      | _ => ()
      }
    }
  }
  change.contents
}
