const MATRIX_SIZE = 5
const MARK = -1

function readorderline!(io)
  line = readline(io)
  orders = map(x->parse(Int8, x), split(line, ","))
  return orders
end

function readmatrix(io)
  matrix = zeros(Int8, MATRIX_SIZE, MATRIX_SIZE)
  for i in 1:MATRIX_SIZE
    line = readline(io)
    columns = map(x->parse(Int8, x), split(line))
    for j in 1:MATRIX_SIZE
      matrix[i,j] = columns[j]
    end
  end
  return matrix
end

function readinput(filename)
  open(filename, "r") do io
    orders = readorderline!(io)
    boards = []
    index = 0
    while ! eof(io)
      if index % 2 == 0
        readline(io)
      else
        m = readmatrix(io)
        push!(boards, m)
      end
      index += 1
    end
    return orders, boards
  end;
end

function iterateboard!(board, fn)
  for i in 1:MATRIX_SIZE
    for j in 1:MATRIX_SIZE
      fn(board, i, j)
    end
  end
end

function mark!(board, value)
  iterateboard!(board, function(board, i, j)
    if board[i,j] == value
      board[i,j] = MARK
    end
  end)
end

function isbingo(row)
  return length(filter(x -> x != MARK, row)) == 0
end

function haswon(board)
  for i = 1:MATRIX_SIZE
    row = board[i,:]
    col = board[:,i]
    if isbingo(row) || isbingo(col)
      return true
    end
  end
  return false
end

function playbingo!(orders, boards)
  for i in 1:length(orders)
    order = orders[i]
    for j in 1:length(boards)
      board = boards[j]
      mark!(board, order)
      won = haswon(board)
      if won
        return i, j
      end
    end
  end
  return nothing, nothing
end

function score(order, board)
  sum = 0
  iterateboard!(board, function(board, i, j)
    if board[i,j] != MARK
      sum += board[i,j]
    end
  end)
  return sum * order
end

function main()
  orders, boards = readinput("input.txt")
  orderindex, boardindex = playbingo!(orders, boards)
  if orderindex !== nothing && boardindex !== nothing
    println(score(orders[orderindex], boards[boardindex]))
  end
end

main()
