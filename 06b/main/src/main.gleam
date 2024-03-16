import gleam/io
import gleam/string
import gleam/int
import gleam/dict
import gleam/list
import gleam/result
import simplifile

/// Dict from `days until reproduction` to `count`.
type Swarm =
  dict.Dict(Int, Int)

pub fn main() {
  let assert Ok(input) = simplifile.read(from: "input.txt")

  input
  |> string.trim
  |> string.split(on: ",")
  |> list.map(with: int.parse)
  |> result.values
  |> to_swarm
  |> simulate(days: 256)
  |> count_fish
  |> int.to_string
  |> io.println
}

fn simulate(days current: Int, input input: Swarm) -> Swarm {
  case current {
    0 -> input
    c -> simulate(c - 1, next_day(input))
  }
}

/// Simulate one day.
fn next_day(fish: Swarm) -> Swarm {
  let assert Ok(zero) = dict.get(fish, 0)
  let assert Ok(one) = dict.get(fish, 1)
  let assert Ok(two) = dict.get(fish, 2)
  let assert Ok(three) = dict.get(fish, 3)
  let assert Ok(four) = dict.get(fish, 4)
  let assert Ok(five) = dict.get(fish, 5)
  let assert Ok(six) = dict.get(fish, 6)
  let assert Ok(seven) = dict.get(fish, 7)
  let assert Ok(eight) = dict.get(fish, 8)

  fish
  |> dict.insert(0, one)
  |> dict.insert(1, two)
  |> dict.insert(2, three)
  |> dict.insert(3, four)
  |> dict.insert(4, five)
  |> dict.insert(5, six)
  |> dict.insert(6, seven + zero)
  |> dict.insert(7, eight)
  |> dict.insert(8, zero)
}

/// Group fish by `days until reproduction` into a Swarm.
fn to_swarm(fish: List(Int)) -> Swarm {
  let empty =
    dict.new()
    |> dict.insert(0, 0)
    |> dict.insert(1, 0)
    |> dict.insert(2, 0)
    |> dict.insert(3, 0)
    |> dict.insert(4, 0)
    |> dict.insert(5, 0)
    |> dict.insert(6, 0)
    |> dict.insert(7, 0)
    |> dict.insert(8, 0)

  fish
  |> list.group(by: fn(a) { a })
  |> dict.map_values(with: fn(_a, b) {
    list.fold(b, from: 0, with: fn(a, _b) { a + 1 })
  })
  |> dict.merge(into: empty)
}

/// Count fish in swarm.
fn count_fish(fish: Swarm) -> Int {
  let sum = dict.fold(fish, 0, fn(acc, _key, value) { acc + value })
  sum
}
