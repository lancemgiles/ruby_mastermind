module Mastermind
  MAX_TURNS = 12

  class Game
    attr_reader :colors, :players, :role
    def initialize(player1, player2)
      @colors = ["red", "green", "blue", "yellow", "purple", "orange"]
      @players = [player1.new(self, :codemaker), player2.new(self, :codebreaker)]
      puts "The computer has a code of four colors. You must guess both the colors and the order."
      puts "You have twelve turns to break the computer's code!"
      puts "The possible colors are: #{@colors.join(", ").}"
    end

    def get_random_colors
      @selection = @colors.shuffle.slice(0,4)
    end
    attr_reader :selection
  end

  class Player
    def initialize(game, role)
      @game = game
      @role = role
    end
  end

  class Human < Player
    def to_s
      "Human Player, #{@role}"
    end
  end

  class Computer < Player  
    def to_s
      "Computer Player, #{@role}"
    end
  end
end

include Mastermind
game = Game.new(Computer, Human)