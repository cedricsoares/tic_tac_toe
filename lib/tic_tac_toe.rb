require 'pry'
require "colorize"


class Board

	attr_accessor :boardcase, :mark
	
	def initialize
		#création d'un Array comprennant trois Array de trois case poiur la structure tu tableau 
		@boardcase = [[],[],[]] 

		#chaque case crée une instance de la claqse BoardCase
		@boardcase[0][0] = BoardCase.new("a1"," ") 
		@boardcase[0][1] = BoardCase.new("b1"," ")
		@boardcase[0][2] = BoardCase.new("c1"," ")
		@boardcase[1][0] = BoardCase.new("a2"," ")
		@boardcase[1][1] = BoardCase.new("b2"," ")
		@boardcase[1][2] = BoardCase.new("c2"," ")
		@boardcase[2][0] = BoardCase.new("a3"," ")
		@boardcase[2][1] = BoardCase.new("b3"," ")
		@boardcase[2][2] = BoardCase.new("c3"," ")
	
	
	end 
end



class BoardCase 

	attr_accessor :name, :mark

	def initialize(name,mark)
		@name = name
		@mark = mark
	end
end


class Player 

	attr_accessor :name, :mark 
	def initialize(name,mark)
		@name = name 
		@mark = mark
	end
end

class Game 

	attr_accessor :player1 , :player2, :board 

	def initialize

		#affichage des règles du jeu 
		puts "Bienvenue dans le jeu du morpion"
		puts "Pour gagner la partie il faut qu'un des joueurs aligne une ligne horizontale, verticale ou diagonale avec des 'X' pour le joueur 1 et des 'O' pour le joueur 2" 
		print "-" * 20 
		puts " "

		#dé&claration des noms des deux joueurs 
		puts "Quel est ton nom joueur 1 ? "
		print ">"
		@player1 = Player.new(gets.chomp, "X")

		puts "Quel est ton nom joueur 2 ? "
		print ">"
		@player2 = Player.new(gets.chomp, "O")
		@board = Board.new

		turn

	end

    def vitory_combo
    	#listong de toutes les combinatoires de victoires 
    	@combo = {}

    	@combo[:combo_l1] = [@board.boardcase[0][0].mark , @board.boardcase[0][1].mark, @board.boardcase[0][2].mark]
    	@combo[:combo_l2] = [@board.boardcase[1][0].mark , @board.boardcase[1][1].mark, @board.boardcase[1][2].mark]
    	@combo[:combo_l3] = [@board.boardcase[2][0].mark , @board.boardcase[2][1].mark, @board.boardcase[2][2].mark]
    	@combo[:combo_c1] = [@board.boardcase[0][0].mark , @board.boardcase[1][0].mark, @board.boardcase[2][0].mark]
    	@combo[:combo_c2] = [@board.boardcase[0][1].mark , @board.boardcase[1][1].mark, @board.boardcase[2][1].mark]
    	@combo[:combo_c3] = [@board.boardcase[0][2].mark , @board.boardcase[1][2].mark, @board.boardcase[2][2].mark]
    	@combo[:combo_d1] = [@board.boardcase[0][0].mark , @board.boardcase[1][1].mark, @board.boardcase[2][2].mark]
    	@combo[:combo_d2] = [@board.boardcase[0][2].mark , @board.boardcase[1][1].mark, @board.boardcase[2][0].mark]

	end

	#méthode de test si une condition de victoire est remplie 
	#les test est réalisé en testant avec signe du joueur en train de jouer 
	def win_test(mark)
	
	vitory_combo
		@combo.each do |k, v|
			if v[0] == mark && v [1] == mark && v[2] == mark 
			return true 
			else 
			return false 
			binding.pry 
			end 
		end

	
	end

=begin 

	#méthode d'affichage du tableau 
	def print_board
		puts "       |   A   |   B   |   C   "
		puts "       |       |       |       "
		puts "   1   |   #{@board.boardcase[0][0].mark}   |   #{@board.boardcase[0][1].mark}   |   #{@board.boardcase[0][2].mark}   "
		puts "       |       |       |       "
		puts "_______|_______|_______|_______"
		puts "       |       |       |       "
		puts "   2   |   #{@board.boardcase[1][0].mark}   |   #{@board.boardcase[1][1].mark}   |   #{@board.boardcase[1][2].mark}   "
		puts "       |       |       |       "
		puts "_______|_______|_______|_______"
		puts "       |       |       |       "
		puts "   3   |   #{@board.boardcase[2][0].mark}   |   #{@board.boardcase[2][1].mark}   |   #{@board.boardcase[2][2].mark}   "
		puts "       |       |       |       "
	end

=end
	#méthode déroulant la partie

def print_board
        puts "       |   A   |   B   |   C   ".red.on_blue.blink
        print "       ".red.on_blue.blink
        puts"        |       |       "
        print "   1   ".red.on_blue.blink
        puts "    #{@board.boardcase[0][0].mark}   |   #{@board.boardcase[0][1].mark}   |   #{@board.boardcase[0][2].mark}   "
        print "       ".red.on_blue.blink
        puts"        |       |       "
        print "_______".red.on_blue.blink
        puts " _______|_______|_______"
        print "       ".red.on_blue.blink
        puts"        |       |       "
        print "   2   ".red.on_blue.blink
        puts "    #{@board.boardcase[1][0].mark}   |   #{@board.boardcase[1][1].mark}   |   #{@board.boardcase[1][2].mark}   "
        print "       ".red.on_blue.blink
        puts "        |       |       "
        print "_______".red.on_blue.blink
        puts " _______|_______|_______"
        print "       ".red.on_blue.blink
        puts"        |       |       "
        print "   3   ".red.on_blue.blink
        puts"    #{@board.boardcase[2][0].mark}   |   #{@board.boardcase[2][1].mark}   |   #{@board.boardcase[2][2].mark}   "
        print "       ".red.on_blue.blink
        puts"        |       |       "
    end

	def turn
		
		#counter servant a compter le nombre de tours
		counter = 0
		print_board
		
		#si aucun des joueurs n'a gagné au bout de neuf tours, la partie se termine sur une égalité 
		while counter < 9

			puts "#{@player1.name} choisis une case"
			place_to_play = gets.chomp

			#tant que la valeur renseignée par un des joueurs ne correspond à un nom de case le joueur est invité à renseigner à nouveau la case qu'il veut joueur 
			unless place_to_play =~/a1|a2|a3|b1|b2|b3|c1|c2|c3/ 
			
				puts "cette case n'existe pas"
				print ">"

				place_to_play = gets.chomp
			end

			#mape la valeur de la case choisie par un joueur à case du plateau de jeu 
			case place_to_play
				when "a1"
				activecase = @board.boardcase[0][0]
				when "b1" 
				activecase = @board.boardcase[0][1]
				when "c1" 
				activecase = @board.boardcase[0][2]
				when "a2"
				activecase = @board.boardcase[1][0]
				when "b2" 
				activecase = @board.boardcase[1][1]
				when "c2" 
				activecase = @board.boardcase[1][2]
				when "a3"
				activecase = @board.boardcase[2][0]
				when "b3" 
				activecase = @board.boardcase[2][1]
				when "c3" 
				activecase = @board.boardcase[2][2]
			end

			#vérification que la case qu'un joueur veut jouet est vide. Dans le cas contraire le joueur doit à nouveau renseigner une case
			while activecase.mark != " "
				puts "Tu ne peux pas rejouer sur une case où un joueur a déjà joué"
				print ">"
				place_to_play = gets.chomp 
				case place_to_play
					when "a1"
					activecase = @board.boardcase[0][0]
					when "b1" 
					activecase = @board.boardcase[0][1]
					when "c1" 
					activecase = @board.boardcase[0][2]
					when "a2"
					activecase = @board.boardcase[1][0]
					when "b2" 
					activecase = @board.boardcase[1][1]
					when "c2" 
					activecase = @board.boardcase[1][2]
					when "a3"
					activecase = @board.boardcase[2][0]
					when "b3" 
					activecase = @board.boardcase[2][1]
					when "c3" 
					activecase = @board.boardcase[2][2]
				end
			end

			#La case sélectionnée prend la valeur de marqueur du joueur. Joueur 1 = "X", Joueur 2 = "O"
			activecase.mark = @player1.mark  
			

			#Affichage du tableau 
			print_board 

			#Appelle le test des conditions de victoires
			#Si une condition de victoire est remplie. La partie se termine en affichant le joueur qui a gagné. 
			#Ensuite les joueur sont invités à relancer une partie en appuyant sur une touche 
			if  win_test(@player1.mark) == true 
				puts "#{@player1.name} a gagné !"
				puts "Appuyez sur une touche si vous voulez rejouer"
				gets 
				Game.new 
			end


			counter += 1

			break if counter == 9


			puts "#{@player2.name} choisis une case"
			place_to_play = gets.chomp
			
			unless place_to_play =~/a1|a2|a3|b1|b2|b3|c1|c2|c3/ 
			
				puts "cette case n'existe pas"

				place_to_play = gets.chomp
			end

			case place_to_play
				when "a1"
				activecase = @board.boardcase[0][0]
				when "b1" 
				activecase = @board.boardcase[0][1]
				when "c1" 
				activecase = @board.boardcase[0][2]
				when "a2"
				activecase = @board.boardcase[1][0]
				when "b2" 
				activecase = @board.boardcase[1][1]
				when "c2" 
				activecase = @board.boardcase[1][2]
				when "a3"
				activecase = @board.boardcase[2][0]
				when "b3" 
				activecase = @board.boardcase[2][1]
				when "c3" 
				activecase = @board.boardcase[2][2]
			end

			while activecase.mark != " "
				puts "Tu ne peux pas rejouer sur une case où un joueur a déjà joué"
				print ">"
				place_to_play = gets.chomp 
				case place_to_play
					when "a1"
					activecase = @board.boardcase[0][0]
					when "b1" 
					activecase = @board.boardcase[0][1]
					when "c1" 
					activecase = @board.boardcase[0][2]
					when "a2"
					activecase = @board.boardcase[1][0]
					when "b2" 
					activecase = @board.boardcase[1][1]
					when "c2" 
					activecase = @board.boardcase[1][2]
					when "a3"
					activecase = @board.boardcase[2][0]
					when "b3" 
					activecase = @board.boardcase[2][1]
					when "c3" 
					activecase = @board.boardcase[2][2]
				end
			end

			activecase.mark = @player2.mark  

		    print_board

			if win_test(@player2.mark) == true 
				puts "#{@player2.name} a gagné !"
				puts "Appuyez sur une touche si vous voulez rejouer"
				gets 
				Game.new 
			end
			
			counter += 1
			break if counter == 9
		

		end

		#Message de fin de partie au bout de neuf tours si aucun des joueurs n'a rempli une condition de victoire
		puts "La partie se termine sur un match nul"
		puts "Appuyez sur une touche si vous voulez rejouer"
		gets 
		Game.new 

	end 

end

Game.new




   

