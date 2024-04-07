module Mastermind
  MAX_TURNS = 12

  class Game
    attr_reader :colors
    def initialize(player1, player2)
      @colors = ["red", "green", "blue", "yellow", "purple", "orange"]
      @players = [player1.new(self, :codemaker), player2.new(self, :codebreaker)]
    end

    def get_random_colors
      selection = @colors.shuffle.slice(0,4)
    end
  end

  class Player
    def initialize(game, role)
      @game = game
      @role = role
    end
  end

  class Human < Player

  end

  class Computer < Player

  end

end

include Mastermind
game = Game.new()
puts game.get_random_colors