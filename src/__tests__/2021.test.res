open Jest
open Expect

describe("Advent of Code 2021", () => {
  describe("Day 1", () => {
    open DepthFinder
    let entries = "src/2021/day1/Data.txt" |> parse

    test("Submarine dephth change: 1226", () => {
      entries |> findDepthChange |> expect |> toEqual(1226)
    })

    test("Sliding depth change: 1252", () => {
      entries |> findSlidingSumDepthChange |> expect |> toEqual(1252)
    })
  })
  describe("Day 2", () => {
    open Navigator
    let entries = "src/2021/day2/Data.txt" |> parse
    test("Final Destination: 2150351", () => {
      entries |> findFinalDestination |> expect |> toEqual(2150351)
    })
    test("Final Destination With Aim: 1842742223", () => {
      entries |> findFinalDestinationWithAim |> expect |> toEqual(1842742223)
    })
  })
})
