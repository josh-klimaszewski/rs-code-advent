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
  let operate = (directions: array<t>, ~useAim=?, ()): destination => {
    let aim = ref(0)
    let position = ref(0)
    let depth = ref(0)
    for i in 0 to directions->Js.Array2.length - 1 {
      switch (directions[i].operation, directions[i].distance, useAim) {
      | (Some("up"), Some(distance), None) => depth := depth.contents - distance
      | (Some("up"), Some(distance), Some(_)) => aim := aim.contents - distance
      | (Some("down"), Some(distance), None) => depth := depth.contents + distance
      | (Some("down"), Some(distance), Some(_)) => aim := aim.contents + distance
      | (Some("forward"), Some(distance), None) => position := position.contents + distance
      | (Some("forward"), Some(distance), Some(_)) => {
          position := position.contents + distance
          switch aim.contents {
          | 0 => ()
          | _ => depth := depth.contents + aim.contents->MathHelpr.multiplyInt(distance)
          }
        }
      | _ => ()
      }
    }
    {position: position.contents, depth: depth.contents}
  }
}

let parse = loc => loc->TextFileParser.parseToStringArray->Js.Array2.map(Direction.make)

let findFinalDestination = entries => {
  let {position, depth} = entries->Direction.operate()
  position->MathHelpr.multiplyInt(depth)
}

let findFinalDestinationWithAim = entries => {
  let {position, depth} = entries->Direction.operate(~useAim=true, ())
  position->MathHelpr.multiplyInt(depth)
}
