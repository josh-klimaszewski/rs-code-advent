// Part 1
// Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.
// Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.

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

// --- Part Two ---
// The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation.
// They offer you a second one if you can find three numbers in your expense report that meet the same criteria.

// In your expense report, what is the product of the three entries that sum to 2020?

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
