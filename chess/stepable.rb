module Stepable
  def moves
    moves = []
    self.move_diffs.each do |diff|
      new_pos = [pos[0] + diff[0], pos[1] + diff[1]]
      if board.valid_pos?(new_pos) && (board[new_pos].nil? || board[new_pos].color != self.color)
        moves << new_pos
      end
    end
    moves
  end
end