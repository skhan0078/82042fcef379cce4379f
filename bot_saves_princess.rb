Class BotSavesPrincess
  grid_size = gets.to_i
  grid_matrix = Array.new(grid_size)
  0.upto(grid_size - 1).each { |i| grid_matrix[i] = gets.strip }
  def displayPathtoPrincess(_grid_size, grid_matrix)
    # cal princess x,y
    princess_x, princess_y = get_princess_xy(grid_matrix)

    # cal mario x,y
    mario_x, mario_y = get_mario_xy(grid_matrix)

    while mario_x > princess_x
      puts 'LEFT'
      mario_x -= 1
    end

    while mario_x < princess_x
      puts 'RIGHT'
      mario_x += 1
    end

    while mario_y > princess_y
      puts 'UP'
      mario_y -= 1
    end

    while mario_y < princess_y
      puts 'DOWN'
      mario_y += 1
    end
  end

  def get_princess_xy(grid_matrix)
    grid_row_with_princess = grid_matrix.detect { |grid_row| grid_row.include?('p') }
    princess_x = grid_row_with_princess.index('p')
    princess_y = grid_matrix.index(grid_row_with_princess)
    princess_x, princess_y
  end

  def get_mario_xy
    grid_row_with_mario = grid_matrix.detect { |grid_row| grid_row.include?('m') }
    mario_x = grid_row_with_mario.index('m')
    mario_y = grid_matrix.index(grid_row_with_mario)
    mario_x, mario_y
  end
end
ob = BotSavesPrincess.new
ob.displayPathtoPrincess(grid_size, grid_matrix)
