require "pry"
class TicTacToe
    attr_reader :board

    WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
        
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "     
        puts "-----------"     
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "     
        puts "-----------"     
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "   
    end

    def input_to_index(input)
        input.to_i-1
    end

    def move(index, token = "X")
        self.board[index] = token
    end

    def position_taken?(index)
        self.board[index] == " " || self.board[index].nil? ? false : true
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Enter where you would like to move (1-9): "
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            token = current_player
            move(index, token)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? {|numbers|
        win1 = numbers[0]
        win2 = numbers[1]
        win3 = numbers[2]
            
        if self.board[win1] == "X" && self.board[win2] == "X" && self.board[win3] == "X"
            return numbers
        elsif self.board[win1] == "O" && self.board[win2] == "O" && self.board[win3] == "O"
            return numbers
        
        end
        }
        
    end

    def full?
        board.all?{|index| index != " "}     
        
    end

    def draw?
        if full? && !won?
            return true
        else
            return false
        end
    end

    def over?
        if won? || full? || draw?
            return true
        end
    end

    def winner
        WIN_COMBINATIONS.any? {|numbers|
            win1 = numbers[0]
            win2 = numbers[1]
            win3 = numbers[2]
                
            if self.board[win1] == "X" && self.board[win2] == "X" && self.board[win3] == "X"
                return "X"
            elsif self.board[win1] == "O" && self.board[win2] == "O" && self.board[win3] == "O"
                return "O"
            
            end
            } 
        return nil
    end

    def play 
        until over? == true
            turn
        end
          
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
          end
    end

    
end