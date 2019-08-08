class Queen < Piece
  include Slideable

  def symbol
    :queen
  end
  
  protected

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end