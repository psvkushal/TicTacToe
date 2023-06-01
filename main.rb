require_relative "ticTacToe"

puts "enter the name of the first player  : "
player1 = gets.chomp
puts "enter the name of the second player : "
player2 = gets.chomp

newGame = GameBoard.new(player1, player2)

isBoardFull = false
isGameOver = false

while !isGameOver && !isBoardFull
  isGameOver = newGame.playTurn
  isBoardFull = newGame.isBoardFull?
end

if isGameOver 
  puts "The winner is #{newGame.player[1 - newGame.currentPlayer]} won the game"
end

if !isGameOver && isBoardFull 
  puts "The match is a draw"
end
