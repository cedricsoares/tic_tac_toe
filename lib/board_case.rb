require 'pry'
require_relative 'board'



class BoardCase 

	attr_accessor :name, :mark

	def initialize(name,mark)
		@name = name
		@mark = mark
	end
end