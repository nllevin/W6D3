class Rook < Piece
  include Slideable

  def symbol
    :rook
  end
  
  protected

  def move_dirs
    horizontal_dirs
  end
end