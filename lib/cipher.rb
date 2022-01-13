class Cipher

  attr_reader :message, :key, :date, :character_set, :shifts

  def initialize(message, key, date)
    @message = message.downcase
    @key = key
    @date = date
    @character_set = ("a".."z").to_a << " "
    @shifts = Shifts.new(@key, @date)
  end

  def prep_message_for_shifts
    message_as_array = @message.split("")
    a_letters = []
    b_letters = []
    c_letters = []
    d_letters = []

    until message_as_array.empty?
      a_letters << message_as_array[0]
      b_letters << message_as_array[1]
      c_letters << message_as_array[2]
      d_letters << message_as_array[3]
      4.times {message_as_array.shift}
    end
    shift_arrays = [a_letters, b_letters.compact, c_letters.compact, d_letters.compact]
  end

  # def encrypted_message_as_array
  #   encrypted_array = []
  #   message_arrays = prep_message_for_shifts
  #   until message_arrays.all? {|array| array.empty?}
  #     message_arrays.each do |array|
  #       until @character_set[0] == array[0]
  #         @character_set = @character_set.rotate
  #         # require 'pry'; binding.pry
  #       end
  #       encrypted_array << @character_set[0]
  #       array.shift
  #     end
  #   end
  #   # encrypted_array[0].zip(encrypted_array[1]).zip(encrypted_array[2]).zip(encrypted_array[3]).flatten.compact.join
  #   encrypted_array.compact
  # end

  def encrypted_message_as_array
    a,b,c,d = prep_message_for_shifts
    a_letters = []
    b_letters = []
    c_letters = []
    d_letters = []
    encrypted_array = [a_letters, b_letters, c_letters, d_letters]
    a.each do |letter|
      until @character_set[0] == letter
        @character_set = @character_set.rotate
      end
      @character_set = @character_set.rotate(shifts.a_shift)
      a_letters << @character_set[0]
    end
    b.each do |letter|
      until @character_set[0] == letter
        @character_set = @character_set.rotate
      end
      @character_set = @character_set.rotate(shifts.b_shift)
      b_letters << @character_set[0]
    end
    c.each do |letter|
      until @character_set[0] == letter
        @character_set = @character_set.rotate
      end
      @character_set = @character_set.rotate(shifts.c_shift)
      c_letters << @character_set[0]
    end
    d.each do |letter|
      until @character_set[0] == letter
        @character_set = @character_set.rotate
      end
      @character_set = @character_set.rotate(shifts.d_shift)
      d_letters << @character_set[0]
    end
    encrypted_array.flatten
  end



end
