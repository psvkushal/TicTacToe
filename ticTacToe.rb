require 'pry-byebug'
#puts "is it printing"
class GameBoard

  attr_accessor :player,  :currentPlayer, :pattern, :boardArray


  def initialize(p1, p2)
     @player = [p1,p2]
     @currentPlayer = 0
     @pattern = ['o','x']
     @boardArray = Array.new(3) {Array.new(3," ")}
  end

  def checkBoard?
    #code for checking if there are 3 x or o consequitively
    matched = false
    #horizontal
    for i in 0...2
      if boardArray[i][0] == boardArray[i][1] && boardArray[i][1] == boardArray[i][2] && boardArray[i][0] != " "
        matched = true
      end
    end
    #vertical
    for i in 0...2
      if boardArray[0][i] == boardArray[1][i] && boardArray[1][i] == boardArray[2][i] && boardArray[0][i] != " "
        matched = true
      end
    end
    #diangonal
     if boardArray[1][1] == boardArray[0][0] && boardArray[1][1] == boardArray[2][2] && boardArray[0][0] != " "
       matched = true
     end
     if boardArray[1][1] == boardArray[0][2] && boardArray[1][1] == boardArray[2][0] && boardArray[1][1] != " "
       matched = true
     end
    return matched
  end

  def printBoard
    #prints the board in the stdout
    print "\n"
    print "  --- --- ---\n"
    for i in 0...3
      print " |"
      #print " i = #{i}\n"
      for j in 0...2 
        #print " j = #{j}\n"
        print " #{boardArray[i][j]} |"
      end
      print "#{boardArray[i][2]}  |\n"
      print "  --- --- ---\n"
    end
  end

  def updateBoard(tileLocation)
    #updates board based on the tileNum given and currPattern
    boardArray[tileLocation[0]][tileLocation[1]] = pattern[currentPlayer]
  end

  def turnOver
    #updates the currentPlayer and the currentPattern after the turn ends
    puts "currentPlayer = #{currentPlayer}"
    @currentPlayer = 1 - @currentPlayer
    puts "Handing over the turn to #{player[currentPlayer]}"
  end

  def getInput()
    puts "the input format of tile location should be in the form \"1,2\" here i = 1 and j = 2 without anyspaces otherwise it will be rejected"
    user_input = gets.chomp
    pattern = /^\d+,\d+$/
    while !user_input.match?(pattern)
      user_input = gets.chomp
    end
    tileLocation = user_input.split(",")
    tileNumx = tileLocation[0].to_i
    tileNumy = tileLocation[1].to_i
    return [tileNumx,tileNumy]
  end

  def isTileEmpty(tileLocation)
    return boardArray[tileLocation[0]][tileLocation[1]] == " " 
  end

  def getTileNum()
    tileLocation = getInput()
    while !isTileEmpty(tileLocation)
      puts "please choose a tile which is empty"
      tileLocation = getInput()
    end
    return tileLocation
  end

  def isBoardFull?()
    boardFull = true 
    outerLoopBreak = false
    for i in 0..2
      for j in 0..2
        if boardArray[i][j] == " "
          boardFull = false
          break
        end
      end
      if outerLoopBreak
        break
      end
    end
    return boardFull
  end

  def playTurn

    #binding.pry
    #play the turn of the current player based on the input 
    matchOver = false
    printBoard()
    puts "#{player[currentPlayer]} turn please choose a tile "
    tileLocation = getTileNum()
    updateBoard(tileLocation)
    matchOver = checkBoard?
    turnOver()
    puts matchOver
    return matchOver
  end
  
end
