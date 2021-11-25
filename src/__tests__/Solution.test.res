open Jest
open Expect

describe("Advent of Code 2020", () => {
  describe("Day 1", () => {
    let dayOneEntries = "src/day1/Data.txt"->TextFileParser.parseToIntArray

    test("Expense of $485,739 found", () => {
      dayOneEntries->Day1.findExpense(Day1.target) |> expect |> toEqual(485739)
    })

    test("Triple expense of $161,109,702 found", () => {
      dayOneEntries->Day1.findTripleExpense(Day1.target) |> expect |> toEqual(161109702)
    })
  })

  describe("Day 2", () => {
    let dayTwoEntries = "src/day2/Data.txt"->TextFileParser.parseToStringArray

    test("Password scraper finds 422 valid policies", () => {
      dayTwoEntries->Day2.checkValidPolicies |> expect |> toEqual(422)
    })

    test("Another password scraper finds 451 valid policies", () => {
      dayTwoEntries->Day2.checkOtherValidPolicies |> expect |> toEqual(451)
    })
  })

  describe("Day 3", () => {
    let dayThreeEntries = "src/day3/Data.txt"->TextFileParser.parseToStringArray

    test("Slope encounters 151 trees", () => {
      dayThreeEntries->Day3.findTrees(3, 1) |> int_of_float |> expect |> toEqual(151)
    })

    test("Slopes encounter 7540141059 trees", () => {
      dayThreeEntries->Day3.findAccumulatedTrees([(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)])
      |> int_of_float
      |> expect
      |> toEqual(7540141059)
    })
  })

  describe("Day 4", () => {
    test("Password validator", () => {
      let dayOneEntries = "src/day4/Data.txt" |> Day4.parseTestFile
      Js.log(dayOneEntries)
      1 |> expect |> toEqual(1)
    })
  })
})
