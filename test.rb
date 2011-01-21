require 'yaml'
class Item
	attr_reader :type
	def initialize( type = nil )
		@type = type
	end
	def to_s
		return "Item of type #{ @type }"
	end
end

class Creature
	attr_reader :maxhealth, :strength, :magic, :defense
	attr_accessor :health, :x, :y
end

class Potion < Item
	attr_reader :value
	def initialize( value )
		@type = "potion"
		@value = value
	end
end

class Player < Creature
	attr_reader :worn, :inventory
	def initialize
		@wearable = [ "plate", "legs", "helmet", "boots", "gloves" ]
		@worn = { }
		@maxhealth = 50
		@health = 50
		
	end
	def wear( item )
		if @wearable.include?( item.type )
			unless @worn.empty?
				unless @worn.value?( item.type )
					@worn[ item ] = item.type
				else
					puts "Can't wear that!"
				end
			else
				@worn[ item ] = item.type
			end
		end
	end
	def take_off( item )
		@worn.delete( item )
	end
	def drink( item )
		if item.type == "potion"
			newhealth = @health + item.value
			if newhealth > @maxhealth
				@health = maxhealth
			else
				@health += item.value
			end
		else
			puts "Can't drink that!"
		end
	end
	def add_inv( item )
	end
end

class Map
	attr_reader :conf
	def initialize( mapfile = nil )
		if mapfile
			@conf = YAML.load_file( mapfile )
		end
	end
	def to_s
		return @conf["map"].join("")
	end
end

