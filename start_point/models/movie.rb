require_relative('../db/sql_runner')
class Movie
  attr_reader :id
  attr_accessor :title, :genre, :rating
  def initialize(options)
    @id = options['id'].to_i unless options['id'] == nil
    @title = options['title']
    @genre = options['genre']
    @rating = options['rating'].to_f
  end

  def save()
    sql = "
    INSERT INTO movies
    (title, genre, rating)
    VALUES
    ($1, $2, $3)
    RETURNING id
    ;"
    values = [@title, @genre, @rating]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end
end
