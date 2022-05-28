package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

const MATRIX_SIZE = 5
const MARK = -1

type Orders []int
type Board [MATRIX_SIZE * MATRIX_SIZE]int

func toMatrixCoordinate(x int, y int) int {
  return x*MATRIX_SIZE + y
}

func getValue(board Board) func(int, int) int {
  return func(x int, y int) int {
    return board[toMatrixCoordinate(x, y)]
  }
}

func getRow(board Board) func(int) []int {
  return func(y int) []int {
    return board[y*MATRIX_SIZE : (y+1)*MATRIX_SIZE]
  }
}

func getCol(board Board) func(int) []int {
  return func(x int) []int {
    res := []int{}
    for i, v := range board {
      if i%MATRIX_SIZE == x {
        res = append(res, v)
      }
    }
    return res
  }
}

func setValue(board Board) func(int, int) func(int) Board {
  return func(x int, y int) func(int) Board {
    return func(newValue int) Board {
      board[toMatrixCoordinate(x, y)] = newValue
      return board
    }
  }
}

func getFile() *os.File {
  if len(os.Args) <= 1 {
    return os.Stdin
  }

  f, err := os.Open(os.Args[1])
  if err != nil {
    log.Fatal(err)
  }
  return f
}

func transform[T, U any](arr []T, fn func(T) U) []U {
  var res []U
  for _, v := range arr {
    res = append(res, fn(v))
  }
  return res
}

func readOrders(s *bufio.Scanner) Orders {
  return transform(strings.Split(s.Text(), ","), func(order string) int {
    res, err := strconv.Atoi(order)
    if err != nil {
      log.Fatalf("Order '%s' cannot be converted to integer!", order)
    }
    return res
  })
}

func readEmptyLine(s *bufio.Scanner) bool {
  res := s.Scan()
  if s.Text() != "" {
    log.Fatalf("Expected empty line but got '%s'!", s.Text())
  }
  return res
}

func readBoard(s *bufio.Scanner) Board {
  var board Board
  for x := 0; x < MATRIX_SIZE; x++ {
    row := strings.Fields(s.Text())
    for y := 0; y < MATRIX_SIZE; y++ {
      num, err := strconv.Atoi(row[y])
      if err != nil {
        log.Fatalf("Cannot convert '%s' to integer!", row[y])
      }
      board = setValue(board)(x, y)(num)
    }
    s.Scan()
  }
  return board
}

func readBoards(s *bufio.Scanner) []Board {
  var boards []Board
  for s.Scan() {
    if s.Text() == "" {
      break
    }
    boards = append(boards, readBoard(s))
  }
  return boards
}

func isBingoArr(arr []int) bool {
  for _, val := range arr {
    if val != MARK {
      return false
    }
  }
  return true
}

func isBingo(board Board) bool {
  for i := 0; i < MATRIX_SIZE; i++ {
    row := getRow(board)(i)
    col := getCol(board)(i)
    if isBingoArr(row) || isBingoArr(col) {
      return true
    }
  }
  return false
}

func mark(board Board, order int) Board {
  for i, val := range board {
    if val == order {
      board[i] = MARK
    }
  }
  return board
}

func playBingo(orders Orders, boards []Board) (int, Board, error) {
  for _, order := range orders {
    bingoBoards := []Board{}
    noBingoBoards := []Board{}

    for _, board := range boards {
      newBoard := mark(board, order)
      if isBingo(newBoard) {
        bingoBoards = append(bingoBoards, newBoard)
      } else {
        noBingoBoards = append(noBingoBoards, newBoard)
      }
    }

    if len(noBingoBoards) <= 0 && len(bingoBoards) == 1 {
      return order, bingoBoards[0], nil
    }
    // Keep boards that are not bingo.
    boards = noBingoBoards
  }
  return 0, Board{}, fmt.Errorf("no bingo found")
}

func sumUnmarked(board Board) int {
  sum := 0
  for _, val := range board {
    if val != MARK {
      sum += val
    }
  }
  return sum
}

func score(order int, board Board) int {
  sum := sumUnmarked(board)
  return order * sum
}

func main() {
  f := getFile()
  defer f.Close()
  s := bufio.NewScanner(f)
  if err := s.Err(); err != nil {
    log.Fatal(err)
  }

  s.Scan()
  orders := readOrders(s)
  readEmptyLine(s)
  boards := readBoards(s)

  order, board, err := playBingo(orders, boards)
  if err != nil {
    log.Fatal(err)
  }

  fmt.Println(score(order, board))
}
