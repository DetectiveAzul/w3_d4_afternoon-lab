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

  def self.all()
    sql = "SELECT * FROM castings;"
    result = SqlRunner.run(sql)
    return result.map { |casting| Casting.new(casting) }
  end

  def self.delete_all()
    sql = "DELETE FROM castings;"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "
      SELECT * FROM castings
      WHERE id = $1
    ;"
    values = [id]
    result = SqlRunner.run( sql, values )
    return Casting.new(result.first) unless result.first == nil
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

  def update()
    sql = "
    UPDATE castings
    SET (star_id, movie_id, fee) =
    ($1, $2, $3)
    WHERE id = $4
    ;"
    values = [@star_id, @movie_id, @fee, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM castings
      WHERE id = $1
    ;"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
