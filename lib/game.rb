class Game
  attr_accessor :board, :player_1, :player_2
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    @board.turn_count % 2 == 0 ? @player_1 : @player_2
  end

  def won?
    WIN_COMBINATIONS.detect do |c|
      @board.cells[c[0]] == @board.cells[c[1]] && @board.cells[c[1]] == @board.cells[c[2]] && @board.taken?(c[0]+1)
      #binding.pry
    end
  end

  def draw?
    !won? && @board.full?
  end

  def over?
    draw? || won?
  end

  def winner
    if combo = won?
      @board.cells[combo[0]]
      #binding.pry
    end
  end

  def turn
    player = current_player
    move = player.move(board)
    if !@board.valid_move?(move)
      turn
    else
      @board.update(move, player)
      @board.display
    end
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
#binding.pry