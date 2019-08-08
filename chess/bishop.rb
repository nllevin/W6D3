class Bishop < Piece
  include Slideable

  def symbol
    :bishop
  end
  
  protected

  def move_dirs
    diagonal_dirs
  end
end