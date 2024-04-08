module Mastermind
  MAX_TURNS = 12

  class Game
    attr_accessor :remaining_turns, :guesses, :selection, :role
    attr_reader :colors, :players
    def initialize(player1, player2)
      puts "One player selects a code of four colors,"
      puts "while the other player must guess the colors and order of the colors."
      puts "You can be the codemaker or the codebreaker."
      puts "Do you want to be the codebreaker? (y/n)"
      choice = gets.chomp
      if choice == "y"
        @computer = player1.new(self, :codemaker)
        @player = player2.new(self, :codebreaker)
        puts "You have twelve turns to break the computer's code!"
        puts "The colors will not repeat, and each place in the code has a color."
      else
        @computer = player1.new(self, :codebreaker)
        @player = player2.new(self, :codemaker)
      end
      @colors = ["red", "green", "blue", "yellow", "purple", "orange"]  
      puts "The possible colors are: #{@colors.join(", ")}."
      @remaining_turns = 12
    end

    def get_random_colors
      @colors.shuffle.slice(0,4)
    end

    def play
      if @player.role == :codebreaker then
        play_as_codebreaker
      else
        play_as_codemaker
      end
    end

    def play_as_codebreaker
      @selection = get_random_colors
      while @remaining_turns <= MAX_TURNS
        @player.get_guess
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
          puts "You have #{@remaining_turns} turns left."
        end
      end
    end

    def play_as_codemaker
      @selection = @player.select_colors
      while remaining_turns <= MAX_TURNS
        @computer.get_guess
        if correct?(@guesses)
          puts "The computer has won!"
          break
        elsif lose?
          puts "You win! The computer couldn't guess correctly."
          break
        else
          puts "The computer is going to try again."
          puts "#{@remaining_turns} turns are left."
        end
      end
    end

    
    def correct_colors?(g)
      if (@selection & @guesses).any?
        puts "#{(@selection & @guesses).sort} are included colors"
        true
      else
        puts "No color matches."
        false
      end
    end

    def correct_index?(g)
      if g == @selection
        puts "All colors were in the correct order"
        true
      else
        ordered = g.map.with_index { |color, i| color == @selection[i]}
        puts "Your placement of colors: #{ordered}."
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
    attr_reader :role
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
    def select_colors
      puts "Please select four of the following: #{@colors.join(", ")}."
      puts "Choose one at a time."
      c = Array.new(4)
      c.each {|color|
        color = gets.chomp
        c.push(color)
      }
      c
    end
  end

  class Computer < Player  
    def to_s
      "Computer Player, #{@role}"
    end

    def get_guess

    end
  end
end

include Mastermind
game = Game.new(Computer, Human)
game.play