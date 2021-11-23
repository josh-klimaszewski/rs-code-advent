let target = 2020

let findExpense = (entries, target) => {
  let expense = ref(0)
  for i in 0 to entries |> Js.Array2.length {
    switch entries->Belt.Array.get(i) {
    | Some(entry) => {
        let missingPair = target - entry
        switch entries->Js.Array2.includes(missingPair) {
        | true => expense := entry * missingPair
        | false => ()
        }
      }
    | _ => ()
    }
  }
  expense.contents
}

let findTripleExpense = (entries, target) => {
  let expense = ref(0)
  for i in 0 to entries |> Js.Array2.length {
    for j in 0 to entries |> Js.Array2.length {
      let firstMissing = entries->Belt.Array.get(i)
      let secondMissing = entries->Belt.Array.get(j)
      switch (firstMissing, secondMissing) {
      | (Some(firstMissing), Some(secondMissing)) =>
        switch firstMissing + secondMissing > target {
        | true => ()
        | false => {
            let final = target - firstMissing - secondMissing
            switch entries->Js.Array2.includes(final) {
            | true => expense := firstMissing * secondMissing * final
            | false => ()
            }
          }
        }
      | _ => ()
      }
    }
  }
  expense.contents
}
