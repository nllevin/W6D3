require 'byebug'

class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color, @board, @pos =
      color, board, pos
  end

  def to_s
    case symbol
    when :pawn
      color == :white ? "\u2659" : "\u265f"
    when :rook
      color == :white ? "\u2656" : "\u265c"
    when :knight
      color == :white ? "\u2658" : "\u265e"
    when :bishop
      color == :white ? "\u2657" : "\u265d"
    when :queen
      color == :white ? "\u2655" : "\u265b"
    when :king
      color == :white ? "\u2654" : "\u265a"
    when :null_piece
      " "
    end
  end

  def empty?
    symbol == :null_piece
  end

  def inspect
    "#{self.class}: color => #{color}, position => #{pos}"
  end
end