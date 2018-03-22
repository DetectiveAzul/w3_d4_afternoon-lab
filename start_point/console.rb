require('pry')
require_relative('./models/movie')
require_relative('./models/star')
require_relative('./models/casting')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

star01 = Star.new({'f_name' => 'Nicholas', 'l_name' => 'Cage'})
star02 = Star.new({'f_name' => 'John', 'l_name' => 'Malkovich'})
star03 = Star.new({'f_name' => 'John', 'l_name' => 'Travolta'})
star04 = Star.new({'f_name' => 'Eva', 'l_name' => 'Mendes'})

movie01 = Movie.new({ 'title' => 'Con Air', 'genre'=>'action', 'rating'=>6.8, 'budget' => 1000000})
movie02 = Movie.new({ 'title' => 'Leaving Las Vegas', 'genre'=>'drama', 'rating'=>7.6, 'budget' => 1000000})
movie03 = Movie.new({ 'title' => 'Face/Off', 'genre'=>'thriller', 'rating'=>7.3, 'budget' => 1000000})
movie04 = Movie.new({ 'title' => 'Ghost Rider', 'genre'=>'superheroes', 'rating'=>5.2, 'budget' => 1000000})

star01.save()
star02.save()
star03.save()
star04.save()

movie01.save()
movie02.save()
movie03.save()
movie04.save()

casting01 = Casting.new({'star_id' => star01.id, 'movie_id' => movie01.id, 'fee' => 100000 })
casting02 = Casting.new({'star_id' => star01.id, 'movie_id' => movie02.id, 'fee' => 100000 })
casting03 = Casting.new({'star_id' => star01.id, 'movie_id' => movie03.id, 'fee' => 200000 })
casting04 = Casting.new({'star_id' => star01.id, 'movie_id' => movie04.id, 'fee' => 200000 })
casting05 = Casting.new({'star_id' => star02.id, 'movie_id' => movie02.id, 'fee' => 500000 })
casting06 = Casting.new({'star_id' => star03.id, 'movie_id' => movie03.id, 'fee' => 500000 })
casting07 = Casting.new({'star_id' => star04.id, 'movie_id' => movie04.id, 'fee' => 500000 })

casting01.save()
casting02.save()
casting03.save()
casting04.save()
casting05.save()
casting06.save()
casting07.save()

binding.pry()
nil
