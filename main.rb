require_relative "lib/hashmap"

test = HashMap.new(0.75)

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

p test
p test.length
p test.buckets.length

test.set('moon', 'silver')
p test
p test.length
p test.buckets.length

p test.entries

