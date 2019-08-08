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
  test.render

  board.move_piece([6, 5], [5, 5])
  test.render
  puts board.checkmate?(:white)
  sleep(2)

  board.move_piece([1, 4], [3, 4])
  test.render
  puts board.checkmate?(:white)
  sleep(2)

  board.move_piece([6, 6], [4, 6])
  test.render
  puts board.checkmate?(:white)
  sleep(2)

  board.move_piece([0, 3], [4, 7])
  test.render
  puts board.checkmate?(:white)
  # loop do
  #   test.render
  #   test.cursor.get_input
  # end
end
# unselected and selected cursor colors?