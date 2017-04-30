require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')
require_relative('../models/screening')

require('pry-byebug')

customer1 = Customer.new({ 'name' => 'Irma', 'funds' => 15})
customer1.save()

customer2 = Customer.new({ 'name' => 'Liam', 'funds' => 10})
customer2.save()

customer3 = Customer.new({ 'name' => 'Caroline', 'funds' => 25})
customer3.save()

film1 = Film.new({ 'title' => 'The Boss Baby', 'price' => 15})
film1.save()

film2 = Film.new({ 'title' => 'Ghost in the Shell', 'price' => 10})
film2.save()

film3 = Film.new({ 'title' => 'Their Finest', 'price' => 20})
film3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id })
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id })
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film3.id })
ticket4.save()

screening1 = Screening.new({ 'film_id' => film1.id, 'show_time' => '20:40' })
screening1.save()

screening2 = Screening.new({ 'film_id' => film2.id, 'show_time' => '12:00' })
screening2.save()

screening3 = Screening.new({ 'film_id' => film3.id, 'show_time' => '15:10' })
screening3.save()

screening4 = Screening.new({ 'film_id' => film3.id, 'show_time' => '19:10' })
screening4.save()


binding.pry
nil
