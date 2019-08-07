require_relative 'piece'
require_relative 'stepable'

class King
  include Stepable

  def symbol
    :King
  end

  protected

  def move_diffs
    [[1,1], [1,0], [1,-1], [0,1], [0,-1], [-1,1], [-1,0], [-1,-1]]
  end
end