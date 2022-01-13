class Shifts

  attr_reader :key, :date, :a_key, :b_key, :c_key, :d_key

  def initialize(key, date)
    @key = key
    @date = date
    @a_key = @key[0..1]
    @b_key = @key[1..2]
    @c_key = @key[2..3]
    @d_key = @key[3..4]
  end

end
