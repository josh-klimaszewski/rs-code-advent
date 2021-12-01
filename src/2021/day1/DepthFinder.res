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

let findSlidingSums = entries => {
  let sums = ref([])
  for i in 0 to entries->Js.Array2.length - 3 {
    sums :=
      sums.contents->Js.Array2.concat([
        entries
        ->Js.Array2.slice(~start=i, ~end_=i + 3)
        ->Js.Array2.reduce((acc, cum) => acc + cum, 0),
      ])
  }
  sums.contents
}

let findSlidingSumDepthChange = entries => entries |> findSlidingSums |> findDepthChange
