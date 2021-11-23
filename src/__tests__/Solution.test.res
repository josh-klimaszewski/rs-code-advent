open Jest
open Expect

let dayOneEntries = "src/day1/Data.txt"->TextFileParser.parseToIntArray

describe("Solution", () => {
  test("Rescript compiles and can be tested", () => {
    1 |> expect |> toEqual(1)
  })
  test("Day 1: Expense of $485,739 found", () => {
    dayOneEntries->Day1.findExpense(2020) |> expect |> toEqual(485739)
  })
  test("Day 1: Triple expense of $161,109,702 found", () => {
    dayOneEntries->Day1.findTripleExpense(2020) |> expect |> toEqual(161109702)
  })
})
