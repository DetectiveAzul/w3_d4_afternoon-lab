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
  end

  def self.delete_all()
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
end
