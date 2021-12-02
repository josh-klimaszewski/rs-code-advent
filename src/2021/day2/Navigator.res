module Direction = {
  type t = {
    operation: option<string>,
    distance: option<int>,
  }
  type destination = {
    position: int,
    depth: int,
  }

  let make = entry => {
    let direction = entry->Js.String2.split(" ")
    let operation = direction->Belt.Array.get(0)
    let distance = direction->Belt.Array.get(1)
    switch (operation, distance) {
    | (Some(operation), Some(distance)) => {
        operation: operation->Some,
        distance: distance->int_of_string->Some,
      }
    | _ => {operation: None, distance: None}
    }
  }
  let operate = (directions: array<t>): destination => {
    let position = ref(0)
    let depth = ref(0)
    for i in 0 to directions->Js.Array2.length - 1 {
      switch (directions[i].operation, directions[i].distance) {
      | (Some("forward"), Some(distance)) => position := position.contents + distance
      | (Some("up"), Some(distance)) => depth := depth.contents - distance
      | (Some("down"), Some(distance)) => depth := depth.contents + distance
      | _ => ()
      }
    }

    {position: position.contents, depth: depth.contents}
  }
}

let parse = loc => loc->TextFileParser.parseToStringArray->Js.Array2.map(Direction.make)

let findFinalDestination = entries => {
  let {position, depth} = entries->Direction.operate
  let final = position->float_of_int *. depth->float_of_int
  final->int_of_float
}
