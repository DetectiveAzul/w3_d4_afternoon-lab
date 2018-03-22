require_relative('../db/sql_runner')
class Star
  attr_reader :id
  attr_accessor :f_name, :l_name
  def initialize(options)
    @id = options['id'].to_i unless options['id'] == nil
    @f_name = options['f_name']
    @l_name = options['l_name']
  end

  def self.all()
    sql = "SELECT * FROM stars;"
    result = SqlRunner.run(sql)
    return result.map { |star| Star.new(star) }
  end

  def self.delete_all()
    sql = "DELETE FROM stars;"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "
      SELECT * FROM stars
      WHERE id = $1
    ;"
    values = [id]
    result = SqlRunner.run( sql, values )
    return Star.new(result.first) unless result.first == nil
  end

  def save()
    sql = "
    INSERT INTO stars
    (f_name, l_name)
    VALUES
    ($1, $2)
    RETURNING id
    ;"
    values = [@f_name, @l_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def update()
    sql = "
    UPDATE stars
    SET (f_name, l_name) =
    ($1, $2)
    WHERE id = $3
    ;"
    values = [@f_name, @l_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM stars
      WHERE id = $1
    ;"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
