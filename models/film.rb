require_relative('../db/sql_runner')
require_relative('./customer')


class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ('#{@title}', #{@price}) 
    RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def Film.find(id)
    sql = "SELECT * FROM films WHERE id = #{id}"
    film_hash = SqlRunner.run(sql)[0]
    film = Film.new(film_hash)
    return film
  end

  def update()
    sql = "UPDATE films SET (title, price) = ('#{@title}', #{@price})
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE film_id = #{@id}"
    return Customer.get_many(sql)
  end

  def number_of_customers()
    return customers.count
  end

  def screenings()
    sql = "SELECT * FROM screenings 
    WHERE film_id = #{@id}"
    return Screening.get_many(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def Film.all()
    sql = "SELECT * FROM films"
    return Film.get_many(sql)
  end

  def Film.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def Film.get_many(sql)
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film) }
  end
  
end