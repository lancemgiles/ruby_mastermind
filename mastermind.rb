module Mastermind
  MAX_TURNS = 12

  class Game
    attr_accessor :remaining_turns, :guesses, :selection
    attr_reader :colors, :players, :role
    def initialize(player1, player2)
      @colors = ["red", "green", "blue", "yellow", "purple", "orange"]
      @players = [player1.new(self, :codemaker), player2.new(self, :codebreaker)]
      puts "The computer has a code of four colors. You must guess both the colors and the order."
      puts "You have twelve turns to break the computer's code!"
      puts "The possible colors are: #{@colors.join(", ")}."
      puts "The colors will not repeat, and each place in the code has a color."
      @remaining_turns = 12
    end

    def get_random_colors
      @colors.shuffle.slice(0,4)
    end

    def play
      @selection = get_random_colors
      while @remaining_turns <= MAX_TURNS
        @players[1].get_guess
        if correct?(@guesses)
          puts "You won! You had #{@remaining_turns} turns left."
          puts "#{@selection}"
          puts "#{@guesses}"
          break
        elsif lose?
          puts "You lose! Better luck next time."
          puts "The answer was #{@selection.join(", ")}."
          break
        else
          puts "Keep trying!"
          puts "You have #{remaining_turns} turns left."
        end
      end
    end

    def correct_colors?(g)
      if (@selection & @guesses).any?
        puts "#{(@selection & @guesses)} are included colors"
        true
      else
        puts "No color matches."
        false
      end
    end

    def correct_index?(g)
      index_match = []
      @selection.each_with_index {|val, i|
        @selection.select {|c|
          if c == g[i]
            index_match.push(g[i])
          end
        }
      }
      puts "#{(index_match & @selection)} were in the correct order."
      if (index_match & @selection) == @selection
        true
      else
        false
      end
    end

    def correct?(g)
      if correct_colors?(g)
        correct_index?(g)
      else
        false
      end
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
    def get_guess
      guess = []
      puts "What is your guess for the first color?"
      one = gets.chomp
      guess.push(one)
      puts "And the second?"
      two = gets.chomp
      guess.push(two)
      puts "Third?"
      three = gets.chomp
      guess.push(three)
      puts "Final position?"
      four = gets.chomp
      guess.push(four)
      puts "Your guess is #{guess.join(", ")}."
      @game.remaining_turns -= 1
      @game.guesses = guess
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
game.play