class Shifts

  attr_reader :key, :date, :a_key, :b_key, :c_key, :d_key, :offset,
              :a_offset, :b_offset, :c_offset, :d_offset,
              :a_shift, :b_shift, :c_shift, :d_shift

  def initialize(key, date)
    @key = key
    @date = date
    @a_key = @key[0..1].to_i
    @b_key = @key[1..2].to_i
    @c_key = @key[2..3].to_i
    @d_key = @key[3..4].to_i
    @offset = ((@date.to_i * @date.to_i).to_s)[-4..-1]
    @a_offset = @offset[-4].to_i
    @b_offset = @offset[-3].to_i
    @c_offset = @offset[-2].to_i
    @d_offset = @offset[-1].to_i
    @a_shift = @a_offset + @a_key
    @b_shift = @b_offset + @b_key
    @c_shift = @c_offset + @c_key
    @d_shift = @d_offset + @d_key
  end

end
