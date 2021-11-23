module Password = {
  type t = {
    password: string,
    policy: Js.Re.t,
    bounds: array<int>,
  }

  let make = input => {
    let [bounds, policy, password] = input->Js.String2.splitAtMost(" ", ~limit=3)
    let bounds = bounds->Js.String2.split("-")->Js.Array2.map(int_of_string)
    let policy =
      policy->Js.String2.substring(~from=0, ~to_=1)->Js.Re.fromStringWithFlags(~flags="ig")
    let password = password->Js.String2.trim
    {password: password, policy: policy, bounds: bounds}
  }
}

let preparePasswords = passwords => passwords->Js.Array2.map(Password.make)

let checkValidPolicies = passwords => {
  passwords->preparePasswords->Js.Array2.reduce((acc, {password, policy, bounds}) => {
    let matches = password->Js.String2.match_(policy)
    switch matches {
    | None => acc
    | Some(matches) =>
      let occurrences = matches->Js.Array2.length
      let [min, max] = bounds
      let satisfiesLowerBounds = occurrences >= min
      let satisfiesUpperBounds = occurrences <= max
      switch (satisfiesLowerBounds, satisfiesUpperBounds) {
      | (true, true) => acc + 1
      | _ => acc
      }
    }
  }, 0)
}

let checkOtherValidPolicies = passwords => {
  passwords->preparePasswords->Js.Array2.reduce((acc, {password, policy, bounds}) => {
    let [firstMatch, secondMatch] =
      bounds->Js.Array2.map(x => password->Js.String2.charAt(x - 1)->Js.String2.match_(policy))
    switch (firstMatch, secondMatch) {
    | (None, Some(_))
    | (Some(_), None) =>
      acc + 1
    | _ => acc
    }
  }, 0)
}
