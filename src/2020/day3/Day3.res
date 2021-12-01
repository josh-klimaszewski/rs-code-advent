let tree = "#"

let findTrees = (map, right, down) => {
  let trees = ref(0)
  let rows = map |> Js.Array2.length
  let curRow = ref(0)
  let curCol = ref(0)

  while curRow.contents < rows {
    let row = map[curRow.contents]
    let pos = row->Js.String2.get(curCol.contents->mod(row |> Js.String2.length))
    switch pos == tree {
    | true => trees := trees.contents + 1
    | false => ()
    }
    curRow := curRow.contents + down
    curCol := curCol.contents + right
  }

  trees.contents->float_of_int
}

let findAccumulatedTrees = (map, slopes) => {
  slopes
  ->Js.Array2.map(((rs, cs)) => findTrees(map, rs, cs))
  ->Js.Array2.reduce((acc, v) => acc *. v, 1.0)
}
