require_relative 'piece'

class Pawn
  def symbol
    :pawn
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def at_start_row?
    (color == :white && pos[0] == 6) || (color == :black && pos[0] == 1)
  end

  def forward_dir
    color == :white ? -1 : 1
  end

  def forward_steps
    row, col = pos
    one_step = [row + forward_dir, col]
    return [] unless board.valid_pos?(one_step) && board[one_step].empty?
    two_steps = [row + 2 * forward_dir, col]
    return [one_step] unless board.valid_pos?(two_steps) && board[two_steps].empty?
    [one_step, two_steps]
  end

  def side_attacks
    row, col = pos
    [[row + forward_dir, col - 1], [row + forward_dir, col + 1]].select do |side_pos|
      board.valid_pos?(side_pos) &&
        !board[side_pos].empty? && 
          board[side_pos].color != color 
    end
  end
end