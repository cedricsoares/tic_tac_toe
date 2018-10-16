require 'pry'
require_relative 'board_case'


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