require_relative 'cursor'
require_relative 'board'
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    system("clear")
    board.rows.each_with_index do |row, i|
      chars = row.map.with_index do |piece, j|
        if cursor.cursor_pos == [i, j]
          background = (cursor.selected ? :red : :green) 
        else
          background = ((i + j).even? ? :white : :light_black)
        end
        (" " + piece.to_s + " ").colorize(:color => :black, :background => background)
      end
      puts chars.join
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  test = Display.new(board)
  loop do
    test.render
    test.cursor.get_input
  end
end
# unselected and selected cursor colors?