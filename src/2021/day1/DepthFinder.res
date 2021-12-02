let parse = loc => loc->TextFileParser.parseToStringArray->Js.Array2.map(int_of_string)

let findDepthChange = entries => {
  let change = ref(0)
  for i in 0 to entries->Js.Array2.length - 1 {
    let cur = entries->Belt.Array.get(i)
    let last = entries->Belt.Array.get(i - 1)
    switch (cur, last) {
    | (Some(cur), Some(last)) if cur > last => change := change.contents + 1
    | _ => ()
    }
  }
  change.contents
}

let findSlidingSums = (entries, range) => {
  let sums = ref([])
  for i in 0 to entries->Js.Array2.length - range {
    sums :=
      sums.contents->Js.Array2.concat([
        entries
        ->Js.Array2.slice(~start=i, ~end_=i + range)
        ->Js.Array2.reduce((acc, cum) => acc + cum, 0),
      ])
  }
  sums.contents
}

let findSlidingSumDepthChange = entries => entries->findSlidingSums(3)->findDepthChange
