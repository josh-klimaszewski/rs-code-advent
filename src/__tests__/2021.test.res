open Jest
open Expect

describe("Advent of Code 2021", () => {
  describe("Day 1", () => {
    let entries = "src/2021/day1/Data.txt" |> DepthFinder.parse
    test("Submarine dephth change: 1226", () => {
      entries |> DepthFinder.findDepthChange |> expect |> toEqual(1226)
    })
  })
})
