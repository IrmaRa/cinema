require_relative('../db/sql_runner')
require_relative('./film')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
    VALUES ('#{@name}', #{@funds}) 
    RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def Customer.find(id)
    sql = "SELECT * FROM customers WHERE id = #{id}"
    customer_hash = SqlRunner.run(sql)[0]
    customer = Customer.new(customer_hash)
    return customer
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds})
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets ON tickets.film_id = films.id
    WHERE customer_id = #{@id}"
    return Film.get_many(sql)
  end

  def buy_ticket(ticket)
    film = Film.find(ticket.film_id) 
    @funds -= film.price
    update()
  end

  def tickets()
    return films.count
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def Customer.all()
    sql = "SELECT * FROM customers"
    return Customer.get_many(sql)
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def Customer.get_many(sql)
    customers = SqlRunner.run(sql)
    return customers.map { |customer| Customer.new(customer) }
  end

end