class Shifts

  attr_reader :date, :offset, :a_offset, :b_offset, :c_offset, :d_offset
  attr_accessor :a_shift, :b_shift, :c_shift, :d_shift,
                :key, :a_key, :b_key, :c_key, :d_key

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

  def get_valid_key
    a1 = a_key.to_i; a2 = a1 + 27; a3 = a2 + 27; a4 = a3 + 27
    b1 = b_key.to_i; b2 = b1 + 27; b3 = b2 + 27; b4 = b3 + 27
    c1 = c_key.to_i; c2 = c1 + 27; c3 = c2 + 27; c4 = c3 + 27
    d1 = d_key.to_i; d2 = d1 + 27; d3 = d2 + 27; d4 = d3 + 27
    a_keys = [a1, a2, a3, a4]; b_keys = [b1, b2, b3, b4]
    c_keys = [c1, c2, c3, c4]; d_keys = [d1, d2, d3, d4]
    d_keys.each do |d_key|
      c_keys.each do |c_key|
        b_keys.each do |b_key|
          a_keys.each do |a_key|
            if (a_key.to_s.rjust(2, "0")[1] == b_key.to_s.rjust(2, "0")[0])
              (@a_key = a_key) && (@b_key = b_key)
            else
              next
            end
            if (@b_key.to_s.rjust(2, "0")[1] == c_key.to_s.rjust(2, "0")[0])
              (@c_key = c_key)
            else
              next
            end
            if @c_key.to_s.rjust(2, "0")[1] == d_key.to_s.rjust(2, "0")[0]
              (@d_key = d_key)
            else
              next
            end
          end
        end
      end
    end
    @key = "#{@a_key.to_s.rjust(2, "0")}#{@b_key.to_s.rjust(2, "0")[1]}#{@c_key.to_s.rjust(2, "0")[1]}#{d_key.to_s.rjust(2, "0")[1]}"
  end
end
