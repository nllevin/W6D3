require_relative 'piece'

class NullPiece
  include Singleton

  def initialize
  end

  def symbol
    :null_piece
  end
end