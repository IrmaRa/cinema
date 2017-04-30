require_relative('../db/sql_runner')
require_relative('./film')
require_relative('./ticket')

class Screening

  attr_reader :id
  attr_accessor :film_id, :show_time

  def initialize(options)
    @id = options['id'].to_i
    @film_id = options['film_id'].to_i
    @show_time = options['show_time']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, show_time)
    VALUES ('#{@film_id}', '#{@show_time}') 
    RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def Screening.all()
    sql = "SELECT * FROM screenings"
    return Screening.get_many(sql)
  end

  def Screening.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def Screening.get_many(sql)
    screenings = SqlRunner.run(sql)
    return screenings.map { |screening| Screening.new(screening) }
  end

end