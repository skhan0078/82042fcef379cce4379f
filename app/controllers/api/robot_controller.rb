class Api::RobotController < ApplicationController
	def order
		# Table's coordinates
		@table_x = 5
		@table_y = 5
		directions = ["NORTH", "EAST", "SOUTH", "WEST"]
		@robot_direction = 0
		command_split = []

		# Robot's coordinates
		@robot_x = 0
		@robot_y = 0
		@robot_placed = false
		tokens = []

		params[:commands].each do |command|
			command_split << command.upcase
			if (command_split.length == 2)
				command_split[1] = command_split[1].split(",")
			else
				command_split[1] = []
			end
			tokens << command_split
		end
		can_move?
		move
		result = tokens.each_with_index do |item, index|
							case item[0]
							when "PLACE"
								set_placement(item)
								break
							when "LEFT"
							when "RIGHT"
								@robot_placed ? rotate(item[0]) : invalid_command(item)
								break
							when "REPORT"
								@robot_placed ? report : invalid_command(item)
								break
							else
								invalid_command(item)
								break
							end
						end
		render json: {result: result}
	end

	def invalid_command(item)
		"Invalid Command"
	end

	def is_below_zero(val)
		val < 0
	end

	def is_beyond_table_limit(val, limit)
		val >= limit
	end

	def is_positive_integer(n)
		n.to_i > 0
	end

	def is_direction(dir)
		@robot_direction.index(dir)
	end

	def which_direction(dir)
		@robot_direction.index(dir)
	end

	def check_place_params(arr)
		arr != [] && arr.length == 3 && is_positive_integer(arr[0]) && is_positive_integer(arr[1]) && arr[2].class == String && is_direction(arr[2]) && !(is_below_zero(arr[0])) && !(is_below_zero(arr[1])) && !(is_beyond_table_limit(arr[0],@table_x)) && !(is_beyond_table_limit(arr[1],@table_y))
	end

	def set_placement(item)
		if (check_place_params(item[1]))
			@robot_x += item[1][0]
			@robot_y += item[1][1]
			@robot_direction = which_direction(item[1][2])
			@robot_placed = true
		end
	end

	def rotate(turn)
		@robot_direction = @robot_direction + (( turn == "LEFT" ? 3 : 1) % 4)
	end

	def can_move?
		case @robot_direction

		when 0  #North
		  !(is_beyond_table_limit(@robot_y + 1, @table_y))
		when 1   #East
			!(is_beyond_table_limit(@robot_x + 1, @table_x))
		when 2 #South
			!(is_below_zero(@robot_y - 1))
		when 3 #West
			!(is_below_zero(@robot_x - 1))
		end
	end

	def move
		if (@robot_direction % 2 == 1) #East or west
			if(@robot_direction == 1) #if it is east
				@robot_x += 1
			else
				@robot_x -= 1
			end
		else
			if(@robot_direction == 0)  #if it is north
				@robot_y += 1
			else
				@robot_y -= 1
			end
		end
	end
end
