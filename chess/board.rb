require_relative 'piece'
require_relative 'stepable'
require_relative 'slideable'
require_relative 'king'
require_relative 'knight'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'pawn'
require_relative 'null_piece'

class Board
	attr_reader :rows

	def initialize
		@rows = Array.new(8) { Array.new(8) }

		(0..7).each do |row|
			color = ([0, 1].include?(row) ? :black : :white )
			(0..7).each do |col|
				pos = [row, col]
				piece_info = [color, self, pos]

				case row
				when 1, 6
					piece = Pawn.new(*piece_info)
				when 0, 7
					case col
					when 0, 7
						piece = Rook.new(*piece_info)
					when 1, 6
						piece = Knight.new(*piece_info)
					when 2, 5
						piece = Bishop.new(*piece_info)
					when 3
						piece = Queen.new(*piece_info)
					when 4
						piece = King.new(*piece_info)
					end
				else
					piece = NullPiece.instance
				end

				add_piece(piece, pos)
			end
		end
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

	def dup
		duped_board = Board.new
		rows.each_with_index do |row, i|
			row.each_with_index do |piece, j|
				pos = [i, j]

				if piece.class == NullPiece
					duped_piece = NullPiece.instance
				else
					duped_piece = piece.class.new(piece.color, duped_board, pos)
				end
				
				duped_board.add_piece(duped_piece, pos)
			end
		end
		duped_board
	end

	def in_check?(color)
		king_pos = find_king(color)
		opposing_pieces = pieces.select { |piece| piece.color != color }
		opposing_pieces.any? { |piece| piece.moves.include?(king_pos) }
	end
	
	def checkmate?(color)
		ally_pieces = pieces.select { |piece| piece.color == color }
		in_check?(color) && ally_pieces.all? { |piece| piece.valid_moves.empty? }
	end

	def find_king(color)
		pieces.find { |piece| piece.symbol == :king && piece.color == color }.pos
	end

	def move_piece(start_pos, end_pos)
		piece = self[start_pos] 
		raise "No piece at starting position" if piece.empty?
		raise "Piece cannot move to that position" unless piece.moves.include?(end_pos) 
		raise "You cannot put yourself into check" unless piece.valid_moves.include?(end_pos)
		self[start_pos], self[end_pos] = NullPiece.instance, piece
		piece.pos = end_pos
	end

	def move_piece!(start_pos, end_pos)
		piece = self[start_pos] 
		self[start_pos], self[end_pos] = NullPiece.instance, piece
		piece.pos = end_pos
	end

	def pieces
		rows.flatten.reject { |piece| piece.symbol == :null_piece }
	end

	def valid_pos?(pos)
		pos.all? { |coord| coord.between?(0, 7) }
	end
end

if __FILE__ == $PROGRAM_NAME
	test = Board.new
	# test.move_piece([1,0],[3,0])	#black pawn down two
	# p test[[3,0]].moves #expect [[4,0]]
	# test.move_piece([0,0],[2,0])	#black castle down two
	# p test[[2,0]].moves # expect [[0-1,0],[2,1-7]]
	# test.move_piece([6,4], [5,4])	#white king's pawn up one
	# p test[[7,3]].moves	# white queen's moves: [[6, 4], [5, 5], [4, 6], [3, 7]]
	# p test[[7,4]].moves # white king's moves: [[6, 4]]
	# p test[[7,5]].moves # white bishop's moves: [[6, 4], [5, 3], [4, 2], [3, 1], [2, 0]]
	# p test[[7,6]].moves # white knight's moves: [[5, 7], [5, 5], [6, 4]]
	# p test.rows[2]
	# test.move_piece([7,5], [2,0]) # white knight captures black castle
	# p test.rows[2]
end