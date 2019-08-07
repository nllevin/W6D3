# PHASE 2
def convert_to_int(str)
  Integer(str)
rescue ArgumentError
  puts "Sorry, bad input: '#{str}' cannot be converted to integer"
  nil 
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  else
    raise CoffeeError if maybe_fruit == 'coffee'
    raise ArgumentError.new "That's not a fruit! Grrr!" 
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue ArgumentError => e
    puts e.message
    retry if e.class == CoffeeError
  end
end  

class CoffeeError < ArgumentError
  def message
    "I'm a friendly monster. Since you gave me coffee, you can try again!"
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new("Years known must be at least 5 years.") if yrs_known.to_i < 5
    raise ArgumentError.new("Name cannot be blank.") if name.length == 0
    raise ArgumentError.new("Favorite pastime cannot be blank.") if fav_pastime.length == 0
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


