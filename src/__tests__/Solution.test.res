open Jest
open Expect

let dayOneEntries = "src/day1/Data.txt"->TextFileParser.parseToIntArray
let dayTwoEntries = "src/day2/Data.txt"->TextFileParser.parseToStringArray

describe("Solution", () => {
  test("Rescript compiles and can be tested", () => {
    1 |> expect |> toEqual(1)
  })
  test("Day 1: Expense of $485,739 found", () => {
    dayOneEntries->Day1.findExpense(Day1.target) |> expect |> toEqual(485739)
  })
  test("Day 1: Triple expense of $161,109,702 found", () => {
    dayOneEntries->Day1.findTripleExpense(Day1.target) |> expect |> toEqual(161109702)
  })
  test("Day 2: Password scraper finds 422 valid policies", () => {
    dayTwoEntries->Day2.checkValidPolicies |> expect |> toEqual(422)
  })
  test("Day 2: Another password scraper finds 451 valid policies", () => {
    dayTwoEntries->Day2.checkOtherValidPolicies |> expect |> toEqual(451)
  })
})
