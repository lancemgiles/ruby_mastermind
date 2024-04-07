module Mastermind
  MAX_TURNS = 12

  class Game
    attr_accessor :colors
    def initialize
      @colors = ["red", "green", "blue", "yellow", "purple", "orange"]
      #@players = [codemaker, codebreaker]
    end

    def get_random_colors
      selection = @colors.shuffle.slice(0,4)
    end
  end

end

include Mastermind
game = Game.new()
puts game.get_random_colors