class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color, @board, @pos =
      color, board, pos
  end

  def symbol
  end

  def empty?
    symbol == :null_piece
  end

  def inspect
    "#{self.class}: color => #{color}, position => #{pos}"
  end
end