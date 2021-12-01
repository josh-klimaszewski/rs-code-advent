open Jest
open Expect

open TextFileParser

describe("Advent of Code 2020", () => {
  describe("Day 1", () => {
    open Day1
    let entries = "src/2020/day1/Data.txt"->parseToIntArray

    test("Expense of $485,739 found", () => {
      entries->findExpense(target) |> expect |> toEqual(485739)
    })

    test("Triple expense of $161,109,702 found", () => {
      entries->findTripleExpense(target) |> expect |> toEqual(161109702)
    })
  })

  describe("Day 2", () => {
    open Day2
    let entries = "src/2020/day2/Data.txt"->parseToStringArray

    test("Password scraper finds 422 valid policies", () => {
      entries->checkValidPolicies |> expect |> toEqual(422)
    })

    test("Another password scraper finds 451 valid policies", () => {
      entries->checkOtherValidPolicies |> expect |> toEqual(451)
    })
  })

  describe("Day 3", () => {
    open Day3
    let entries = "src/2020/day3/Data.txt" |> parseToStringArray

    test("Slope encounters 151 trees", () => {
      entries->findTrees(3, 1) |> int_of_float |> expect |> toEqual(151)
    })

    test("Slopes encounter 7540141059 trees", () => {
      entries->findAccumulatedTrees([(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)])
      |> int_of_float
      |> expect
      |> toEqual(7540141059)
    })
  })

  describe("Day 4", () => {
    open Day4
    let entries = "src/2020/day4/Data.txt" |> parseTestFile

    test("Password validator: 190 valid field shapes", () => {
      entries |> countValidShapes |> expect |> toEqual(190)
    })

    test("Password validator: 121 valid fields", () => {
      entries |> findValidEntries |> expect |> toEqual(121)
    })
  })

  describe("Day 5", () => {
    open Day5
    let entries = "src/2020/day5/Data.txt" |> parse

    test("Partitioner: Highest seat ID of 935", () => {
      entries |> findHighestSeat |> expect |> toEqual(935)
    })

    test("Find missing seat id of 743", () => {
      entries |> findMissingSeat |> expect |> toEqual(743)
    })
  })
  describe("Day 6", () => {
    open Day6
    let entries = "src/2020/day6/Data.txt" |> parse

    test("Find sum of unique answers: 6506", () => {
      entries |> findSumOfUniqueAnswers |> expect |> toEqual(6506)
    })

    // test("Find sum of answers everyone answered: ?", () => {
    //   1 |> expect |> toEqual(1)
    // })
  })
})
