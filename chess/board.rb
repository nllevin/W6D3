require_relative 'piece'

class Board
	attr_reader :rows

	def initialize
		@rows = Array.new(8) { Array.new(8) }
		pieces
	end

	def [](pos)
		row, col = pos
		rows[row][col]
	end

	def []=(pos, val)
		row, col = pos
		rows[row][col] = val
	end

	def add_piece(piece, pos)
		self[pos] = piece
	end

	def move_piece(start_pos, end_pos)
		piece = self[start_pos] 
		raise "No piece at starting position" if piece.nil?
		raise "End position is off the board" unless valid_pos?(end_pos)
		self[start_pos], self[end_pos] = nil, piece
	end

	def pieces
		(0..7).each do |row|
			(0..7).each do |col|
				pos = [row, col]
				if row.between?(2,5)
					self[pos] = nil
				else
					piece = Piece.new(:c, self, pos)
					add_piece(piece, pos)
				end
			end
		end
	end

	def valid_pos?(pos)
		pos.all? { |coord| coord.between?(0, 7) }
	end
end