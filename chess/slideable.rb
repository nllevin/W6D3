module Slideable
  def horizontal_dirs
    HORIZONTAL_DIRS.dup
  end

  def diagonal_dirs
    DIAGONAL_DIRS.dup
  end

  def moves
    moves = []
    self.move_dirs.each do |dir| 
      dx, dy = dir
      moves += grow_unblocked_moves_in_dir(dx, dy)
    end
    moves
  end

  private

  HORIZONTAL_DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  DIAGONAL_DIRS = [[1, 1], [-1, -1], [1, -1], [-1, 1]]

  def grow_unblocked_moves_in_dir(dx, dy)
    unblocked_moves = []
    new_pos = [pos[0] + dx, pos[1] + dy]

    while board.valid_pos?(new_pos) && board[new_pos] == nil
      unblocked_moves << new_pos
      new_pos = [new_pos[0] + dx, new_pos[1] + dy] 
    end
    
    if board.valid_pos?(new_pos) && board[new_pos].color != self.color
      unblocked_moves << new_pos
    end

    unblocked_moves
  end

end


