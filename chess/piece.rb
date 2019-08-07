require_relative 'board'

class Piece
  attr_reader :color, :pos

  def initialize(color, board, pos)
    @color, @board, @pos =
      color, board, pos
  end

  def inspect
    "Piece: color => #{color}, position => #{pos}"
  end

  def moves
  end
end