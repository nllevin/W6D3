require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def symbol
    :null_piece
  end
end