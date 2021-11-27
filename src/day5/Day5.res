// ->Js.Array2.map(Js.String2.split(""))

/*
['F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'L', 'L', 'L', 'L']

*/

@val external parseInt: (string, int) => int = "parseInt"

module BoardingPass = {
  type t = {
    row: int,
    column: int,
    id: int,
  }

  let toBit = letter => {
    switch letter {
    | "F"
    | "L" => "0"
    | _ => "1"
    }
  }

  let toBits = letters =>
    letters->Js.String2.split("")->Js.Array2.map(toBit)->Js.Array2.joinWith("")

  let toId = (row, column) => {
    let row = row->Belt.Int.toFloat *. 8.0
    let row = row->int_of_float
    row + column
  }

  let make = direction => {
    let row = direction->Js.String2.substring(~from=0, ~to_=7)->toBits->parseInt(2)
    let column = direction->Js.String2.substringToEnd(~from=7)->toBits->parseInt(2)
    let id = row->toId(column)
    {row: row, column: column, id: id}
  }
}

let parse = data => data->TextFileParser.parseToStringArray->Js.Array2.map(BoardingPass.make)

let sortById = (a: BoardingPass.t, b: BoardingPass.t) => b.id - a.id

let findHighestSeat = directions => {
  let sorted = directions->Js.Array2.sortInPlaceWith(sortById)
  let first = sorted[0]
  first.id
}
