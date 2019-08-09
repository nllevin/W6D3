require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game
  attr_reader :board, :display, :players
  attr_accessor :current_player

  def initialize
    @board = Board.new
    @display = Display.new(board)
    @players = { white: HumanPlayer.new(:white, display),
      black: HumanPlayer.new(:black, display) }
    @current_player = :white
  end

  def play
    until board.checkmate?(current_player)
      display.render
      notify_players

      begin
        start_pos, end_pos = players[current_player].make_move
        board.move_piece(start_pos, end_pos)
        raise "You cannot move opponent's piece" unless board[start_pos].color == current_player
      rescue StandardError => e
        puts e.message
        puts "Try again"
        retry
      end


      swap_turn!
    end

    display.render
    winner = (current_player == :white ? :black : :white)
    puts "Checkmate! #{winner.capitalize} is the winner!"
  end

  private

  def swap_turn!
    if current_player == :white
      self.current_player = :black
    else
      self.current_player = :white
    end
  end

  def notify_players
    puts "Check!" if board.in_check?(current_player)
    puts "Your move, #{current_player}"
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end