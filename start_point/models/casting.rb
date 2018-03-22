require_relative('../db/sql_runner')
class Casting
  attr_reader :id
  attr_accessor :movie_id, :star_id, :fee
  def initialize(options)
    @id = options['id'].to_i unless options['id'] == nil
    @movie_id = options['movie_id'].to_i
    @star_id = options['star_id'].to_i
    @fee = options['fee'].to_i
  end

  def save()
    sql = "
    INSERT INTO castings
    (star_id, movie_id, fee)
    VALUES
    ($1, $2, $3)
    RETURNING id
    ;"
    values = [@star_id, @movie_id, @fee]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end
end
