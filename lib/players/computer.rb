module Players
  class Computer < Player
    def move(board)
      move = nil

      if !board.taken?(5)
        move = "5"
      elsif board.turn_count == 1
        move = "1"
      elsif board.turn_count == 2
        move = [1,3,7,9].detect{|i| !board.taken?(i)}.to_s
      elsif board.turn_count == 3 && (board.position(1) == board.position(9) || board.position(3) == board.position(7))
        move = "2"
      else
        Game::WIN_COMBINATIONS.detect do |c|
          if c.select{|i| board.position(i+1) == token}.size == 2 && c.any?{|i| board.position(i+1) == " "}
            move = c.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
          elsif c.select{|i| board.position(i+1) != " " && board.position(i+1) != token}.size == 2 && c.any?{|i| board.position(i+1) == " "}
            move = c.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
          end
        end
        move = [1,2,3,4,5,6,7,8,9].detect{|i| !board.taken?(i)}.to_s if move == nil
      end
      move
    end
  end
end