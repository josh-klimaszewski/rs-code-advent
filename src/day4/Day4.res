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
  ->TextFileParser.parseByNewLine
  ->Js.Array2.map(x => x->Js.String2.split(" ")->Js.Array2.map(x => x->Js.String2.split(":")))
  ->Js.Array2.map(Form.make)
}

let hasValidShape = (form: Form.t): bool => {
  switch form {
  | {
      ecl: Some(_),
      pid: Some(_),
      eyr: Some(_),
      hcl: Some(_),
      hgt: Some(_),
      byr: Some(_),
      iyr: Some(_),
    } => true
  | _ => false
  }
}

let countValidShapes = forms => forms->Js.Array2.filter(hasValidShape)->Js.Array2.length

// byr (Birth Year) - four digits; at least 1920 and at most 2002.
// iyr (Issue Year) - four digits; at least 2010 and at most 2020.
// eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
// hgt (Height) - a number followed by either cm or in:
// If cm, the number must be at least 150 and at most 193.
// If in, the number must be at least 59 and at most 76.
// hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
// ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
// pid (Passport ID) - a nine-digit number, including leading zeroes.
// cid (Country ID) - ignored, missing or not.

let validHairColor = color => %re(`/^#\w{6}$/`)->Js.Re.test_(color)

let validEyeColor = color =>
  switch color {
  | "amb"
  | "blu"
  | "brn"
  | "gry"
  | "grn"
  | "hzl"
  | "oth" => true
  | _ => false
  }

let validPasportId = id => %re(`/^\d{9}$/`)->Js.Re.test_(id)

let validBirthYear = year => {
  let intYear = year->int_of_string
  intYear >= 1920 && intYear <= 2002
}

let validIssueYear = year => {
  let intYear = year->int_of_string
  intYear >= 2010 && intYear <= 2020
}

let validExpYear = year => {
  let intYear = year->int_of_string
  intYear >= 2020 && intYear <= 2030
}

let validHeight = height => {
  switch height {
  | h if h->Js.String2.includes("cm") => {
      let h = h->Js.String2.replace("cm", "")->int_of_string
      switch h {
      | h if h >= 150 && h <= 193 => true
      | _ => false
      }
    }
  | h if h->Js.String2.includes("in") => {
      let h = h->Js.String2.replace("in", "")->int_of_string
      switch h {
      | h if h >= 59 && h <= 76 => true
      | _ => false
      }
    }
  | _ => false
  }
}

let isValid = (form: Form.t): bool => {
  switch form {
  | {
      ecl: Some(ecl),
      pid: Some(pid),
      eyr: Some(eyr),
      hcl: Some(hcl),
      hgt: Some(hgt),
      byr: Some(byr),
      iyr: Some(iyr),
    } =>
    ecl->validEyeColor &&
    pid->validPasportId &&
    eyr->validExpYear &&
    hcl->validHairColor &&
    hgt->validHeight &&
    byr->validBirthYear &&
    iyr->validIssueYear
  | _ => false
  }
}

let findValidEntries = entries => entries->Js.Array2.filter(isValid)->Js.Array2.length
