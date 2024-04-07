module Mastermind
  MAX_TURNS = 12

  class Game
    attr_reader :colors, :players, :role, :remaining_turns
    def initialize(player1, player2)
      @colors = ["red", "green", "blue", "yellow", "purple", "orange"]
      @players = [player1.new(self, :codemaker), player2.new(self, :codebreaker)]
      puts "The computer has a code of four colors. You must guess both the colors and the order."
      puts "You have twelve turns to break the computer's code!"
      puts "The possible colors are: #{@colors.join(", ").}"
      puts "The colors will not repeat, and each place in the code has a color."
      @remaining_turns = 12
    end

    def get_random_colors
      @selection = @colors.shuffle.slice(0,4)
    end
    attr_accessor :selection

    def play
      while @remaining_turns <= MAX_TURNS
        get_random_colors
        self.guesses = @players[1].get_guess
        if correct?(self.guesses)
          puts "You won! You had #{:remaining_turns} left."
          break
        elsif lose?
          puts "You lose! Better luck next time."
          puts "The answer was #{@selection.join(", ")}."
          break
        else
          puts "Keep trying!"
          return
        end
      end
    end

    def correct?(g)
      # for each color in selection
      @selection.each_with_index { |color, index|
        unless g[index] == color
          if (@selection & g).any?
            color_matches = (@selection & g)
            puts "Color matches: #{color_matches.join(", ")}."
          elsif @selection[index] == g[index]
            index_matches = @selection.select {|c| @selection[index] == g[index]}
            puts "Placement matches: #{index_matches.join(", ")}."
          end
          false
        else
          true
        end
        }
    end
      # compare with guess
      # unless completely correct:
        # first check if any colors are correct, regardless of position
        # then check if any positions are correct
        # print which colors were correct
        # print which positions were also correct
        # @remaining_Turns -= 1
        # return false
      # if completely correct
        # return true
    end
    def lose?
      if @remaining_turns <= 0
        true
      else
        false
      end
    end
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
    attr_accessor :guesses
    def get_guess
      guess = []
      puts "What is your guess for the first color?"
      one = gets.chomp
      guess.push(one)
      puts "And the second?"
      two = gets.chomp
      guess.push(two)
      puts "Third?"
      three - gets.chomp
      guess.push(three)
      puts "Final position?"
      four = gets.chomp
      guess.push(four)
      puts "Your guess is #{@guess.join(", ")}."
      guess
  end

  class Computer < Player  
    def to_s
      "Computer Player, #{@role}"
    end
  end
end

include Mastermind
game = Game.new(Computer, Human)