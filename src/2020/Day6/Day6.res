module Quiz = {
  let make = char =>
    char->Js.Array2.map(x => x->Js.String2.split("")->Js.Array2.filter(c => c != " "))
}

let parse = loc => loc->TextFileParser.parseByNewLine->Quiz.make

module StringComp = Belt.Id.MakeComparable({
  type t = string
  let cmp = Pervasives.compare
})

let findUniqueAnswers = group => {
  Belt.Set.make(~id=module(StringComp))
  ->Belt.Set.mergeMany(group)
  ->Belt.Set.toArray
  ->Js.Array2.length
}

let findSumOfUniqueAnswers = groups =>
  groups->Js.Array2.map(findUniqueAnswers)->Js.Array2.reduce((acc, cur) => acc + cur, 0)

// let findSumOfAllAnswered = groups => {
//   let set = Belt.Set.make(~id=module(StringComp))
//   groups->Js.Array2.forEach(group => {
//     group->Js.Array2.forEach(answer => {
//       switch answer {
//       | x if groups->Js.Array2.every(group => group->Js.Array2.includes(x)) =>
//         set->Belt.Set.add(x)->ignore
//       | _ => ()
//       }
//     })
//   })
//   Js.log(set->Belt.Set.toArray)
// }
