class HashMap
  attr_accessor :buckets
  attr_reader :load_factor

  def initialize(load_factor)
    @buckets = Array.new(16)
    @load_factor = load_factor
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  def set(key, value)
    index = calculate_index(key)

    raise IndexError if index.negative? || index >= @buckets.length

    if buckets[index].nil?
      buckets[index] = []
      buckets[index].push(key, value)
    elsif buckets[index].include?(key)
      inner_index = nil
      buckets[index].each_with_index { |saved_key, index| inner_index = index if key == saved_key}
      buckets[index][inner_index + 1] = value
    else
      buckets[index].push(key, value)
    end
  end

  def get(key)
    index = calculate_index(key)

    raise IndexError if index.negative? || index >= @buckets.length

    if buckets[index].nil?
      nil
    elsif buckets[index].include?(key)
      inner_index = nil
      buckets[index].each_with_index { |saved_key, index| inner_index = index if key == saved_key}
      buckets[index][inner_index + 1]
    end
  end

  def calculate_index(key)
    hash(key) % buckets.length
  end
end
