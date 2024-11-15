# Advent of Code 2021

My [Advent of Code 2021][aoc-2021] solutions.

Goal is to solve each ~~part~~ day with a new language.
Also fun.

## Overview

| DAY                                       | A                                  | B                                          |
| :---------------------------------------- | :--------------------------------- | :----------------------------------------- |
| [01](https://adventofcode.com/2021/day/1) | [`Bash`](./01a/main.sh)            | [`PHP 8.0`](./01b/main.php)                |
| [02](https://adventofcode.com/2021/day/2) | [`Python 3.10`](./02a/main.py)     | [`C`](./02b/main.c)                        |
| [03](https://adventofcode.com/2021/day/3) | [`Perl 5.34`](./03a/main.pl)       | [`Ruby 3.1.2`](./03b/main.rb)              |
| [04](https://adventofcode.com/2021/day/4) | [`Julia 1.7.2`](./04a/main.jl)     | [`Go 1.18.2`](./04b/main.go)               |
| [05](https://adventofcode.com/2021/day/5) | [`Zig 0.10.0`](./05a/main.zig)     | [`GnuCobol 3.0`](./05b/main.cbl)           |
| [06](https://adventofcode.com/2021/day/6) | [`Clojure 1.11.1`](./06a/main.clj) | [`Gleam 1.0.0`](./06b/main/src/main.gleam) |
| [06](https://adventofcode.com/2021/day/7) | [`Kotlin 1.9.23`](./07a/main.kt)   | [`Kotlin 1.9.23`](./07b/main.kt)           |

## Run

| DAY                                              | COMMAND                                                                                                                      |
| :----------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------- |
| [01a](https://adventofcode.com/2021/day/1)       | `docker run -it --rm -v "$PWD/01a":/usr/myapp -w /usr/myapp bash:5.1 bash main.sh input.txt`                                 |
| [01b](https://adventofcode.com/2021/day/1#part2) | `docker run -it --rm -v "$PWD/01b":/usr/myapp -w /usr/myapp php:8.0.0-alpine php main.php input txt`                         |
| [02a](https://adventofcode.com/2021/day/2)       | `docker run -it --rm -v "$PWD/02a":/usr/myapp -w /usr/myapp python:3.10-slim python main.py input.txt`                       |
| [02b](https://adventofcode.com/2021/day/2#part2) | `docker run -it --rm -v "$PWD/02b":/usr/myapp -w /usr/myapp gcc:9.4 gcc main.c && ./02b/a.out 02b/input.txt && rm 02b/a.out` |
| [03a](https://adventofcode.com/2021/day/3)       | `docker run -it --rm -v "$PWD/03a":/usr/myapp -w /usr/myapp perl:5.34-slim perl main.pl input.txt`                           |
| [03b](https://adventofcode.com/2021/day/3#part2) | `docker run -it --rm -v "$PWD/03b":/usr/myapp -w /usr/myapp ruby:3.1.2-slim ruby main.rb input.txt`                          |
| [04a](https://adventofcode.com/2021/day/4)       | `docker run -it --rm -v "$PWD/04a":/usr/myapp -w /usr/myapp julia:1.7.2-alpine julia main.jl input.txt`                      |
| [04b](https://adventofcode.com/2021/day/4#part2) | `docker run -it --rm -v "$PWD/04b":/usr/myapp -w /usr/myapp golang:1.18.2 go run main.go input.txt`                          |
| [05a](https://adventofcode.com/2021/day/5)       | `docker run -it --rm -v "$PWD/05a":/usr/myapp -w /usr/myapp protocall7/zig:0.10.0 zig run main.zig -- input.txt`             |
| [05b](https://adventofcode.com/2021/day/5#part2) | `docker run -it --rm -v "$PWD/05b":/usr/myapp -w /usr/myapp esolang/cobol:latest cobol main.cbl`                             |
| [06a](https://adventofcode.com/2021/day/6)       | `docker run -it --rm -v "$PWD/06a":/usr/myapp -w /usr/myapp clojure:temurin-17-alpine clojure -M main.clj`                   |
| [06b](https://adventofcode.com/2021/day/6#part2) | `docker build -t 06b-gleam 06b && docker run --rm 06b-gleam`                                                                 |
| [07a](https://adventofcode.com/2021/day/7)       | `docker run --rm -v "$PWD/07a":/usr/myapp -w /usr/myapp esolang/kotlin:2.4.0 kotlin main.kt`                                 |
| [07b](https://adventofcode.com/2021/day/7#part2) | `docker run --rm -v "$PWD/07b":/usr/myapp -w /usr/myapp esolang/kotlin:2.4.0 kotlin main.kt`                                 |

## License

This project is released under the MIT license.
Check out the [LICENSE](LICENSE) file for more information.

[aoc-2021]: https://adventofcode.com/2021
