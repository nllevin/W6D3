class HumanPlayer
  attr_reader :color, :display
  
  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move
    response = []

    2.times do 
      input = nil
      until input
        input = display.cursor.get_input
        display.render
      end
      response << input
    end

    response
  end
end