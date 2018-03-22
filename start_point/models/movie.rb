require_relative('../db/sql_runner')
require_relative('./star')
class Movie
  attr_reader :id
  attr_accessor :title, :genre, :rating, :budget
  def initialize(options)
    @id = options['id'].to_i unless options['id'] == nil
    @title = options['title']
    @genre = options['genre']
    @rating = options['rating'].to_f
    @budget = options['budget'].to_i
  end

  def self.all()
    sql = "SELECT * FROM movies;"
    result = SqlRunner.run(sql)
    return result.map { |movie| Movie.new(movie) }
  end

  def self.delete_all()
    sql = "DELETE FROM movies;"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "
      SELECT * FROM movies
      WHERE id = $1
    ;"
    values = [id]
    result = SqlRunner.run( sql, values )
    return Movie.new(result.first) unless result.first == nil
  end

  def save()
    sql = "
    INSERT INTO movies
    (title, genre, rating, budget)
    VALUES
    ($1, $2, $3, $4)
    RETURNING id
    ;"
    values = [@title, @genre, @rating, @budget]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def update()
    sql = "
    UPDATE movies
    SET (title, genre, rating, budget) =
    ($1, $2, $3, $4)
    WHERE id = $5
    ;"
    values = [@title, @genre, @rating, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies
      WHERE id = $1
    ;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def stars()
      sql = "
        SELECT stars.* FROM stars
        INNER JOIN castings
        ON stars.id = star_id
        INNER JOIN movies
        ON movies.id = movie_id
        WHERE movies.id = $1
      ;"
      values = [@id]
      stars_array = SqlRunner.run(sql, values)
      return stars_array.map { |star| Star.new(star) }
  end

  def remaining_budget()
    sql = "
    SELECT fee from castings
    WHERE movie_id = $1;
    ;"
    values = [@id]
    array_of_fees = SqlRunner.run(sql, values)
    result = @budget
    array_of_fees.each { |fee| result -= fee['fee'].to_i }
    return result
  end
end
