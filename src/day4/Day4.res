module Form = {
  type t = {
    ecl: option<string>,
    pid: option<string>,
    eyr: option<string>,
    hcl: option<string>,
    byr: option<string>,
    iyr: option<string>,
    cid: option<string>,
    hgt: option<string>,
  }

  let parse = (x, key) => {
    let foundPair = x->Js.Array2.find(x => x[0] == key)
    switch foundPair {
    | Some(pid) => Some(pid[1])
    | _ => None
    }
  }

  let make = x => {
    {
      ecl: x->parse("ecl"),
      pid: x->parse("pid"),
      eyr: x->parse("eyr"),
      hcl: x->parse("hcl"),
      byr: x->parse("byr"),
      iyr: x->parse("iyr"),
      cid: x->parse("cid"),
      hgt: x->parse("hgt"),
    }
  }
}

let parseTestFile = filepath => {
  filepath
  ->TextFileParser.parseToStringArray
  ->Js.Array2.filter(x => x != "")
  ->Js.Array2.map(x => x->Js.String2.split(" ")->Js.Array2.map(x => x->Js.String2.split(":")))
  ->Js.Array2.map(Form.make)
}
