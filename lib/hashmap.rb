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

    if buckets[index].nil?
      buckets[index] = []
      buckets[index].push(key, value)
    elsif has?(key)
      inner_index = get_inner_index_of_key(index, key)
      buckets[index][inner_index + 1] = value
    else
      buckets[index].push(key, value)
    end

    expand_buckets
  end

  def expand_buckets
    if length > buckets.length * load_factor
      current_entries = entries

      self.buckets = Array.new(buckets.length * 2)

      current_entries.each do |entry|
        set(entry[0], entry[1])
      end

    end
  end

  def get(key)
    index = calculate_index(key)

    if buckets[index].nil?
      nil
    elsif has?(key)
      inner_index = get_inner_index_of_key(index, key)
      buckets[index][inner_index + 1]
    end
  end

  def has?(key)
    index = calculate_index(key)

    if buckets[index].nil?
      false
    elsif buckets[index].include?(key)
      true
    end
  end

  def remove(key)
    index = calculate_index(key)

    if has?(key)
      inner_index = get_inner_index_of_key(index, key)
      deleted_value = buckets[index][inner_index + 1]
      buckets[index][inner_index] = nil
      buckets[index][inner_index + 1] = nil
      buckets[index] = buckets[index].compact
      buckets[index] = nil if buckets[index] == []
      deleted_value
    end
  end

  def get_inner_index_of_key(index, key)
    inner_index = nil
    buckets[index].each_with_index { |saved_key, i| inner_index = i if key == saved_key }
    inner_index
  end

  def calculate_index(key)
    index = hash(key) % buckets.length
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  def length
    total = 0
    buckets.flatten.each { |element| total += 1 unless element.nil? }
    total / 2
  end

  def clear
    self.buckets = Array.new(buckets.length)
  end

  def keys
    keys = []
    buckets.flatten.compact.each_with_index { |element, i| keys.push(element) if i.even? }
    keys
  end

  def values
    values = []
    buckets.flatten.compact.each_with_index { |element, i| values.push(element) if i.odd? }
    values
  end

  def entries
    entries = Array.new(length) { [] }
    i = 0

    length.times do
      entries[i][0] = keys[i]
      entries[i][1] = values[i]
      i += 1
    end
    entries
  end
end
