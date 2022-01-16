class Cipher

  attr_reader :message, :key, :date, :character_set, :shifts

  def initialize(message, key = "-00000", date)
    @message = message.downcase
    @key = key
    @date = date
    @character_set = ("a".."z").to_a << " "
    @shifts = Shifts.new(@key, @date)
  end

  def prep_message_for_shifts
    # CAN I USE A HASH FOR BETTER ORGANIZING OF DATA?
    message_as_array = @message.split("")
    a_letters = []; b_letters = []; c_letters = []; d_letters = []
    until message_as_array.empty?
      a_letters << message_as_array[0]
      b_letters << message_as_array[1]
      c_letters << message_as_array[2]
      d_letters << message_as_array[3]
      4.times {message_as_array.shift}
    end
    shifted_arrays = [a_letters, b_letters.compact, c_letters.compact, d_letters.compact]
  end

  def encrypted_message_as_array
    # CAN I USE A HASH FOR BETTER ORGANIZING OF DATA?
    message_array = prep_message_for_shifts
    a_letters = []; b_letters = []; c_letters = []; d_letters = []
    encrypted_array = [a_letters, b_letters, c_letters, d_letters]
    message_array[0].each do |letter|
      if @character_set.include?(letter)
        until @character_set[0] == letter
          @character_set = @character_set.rotate
        end
        @character_set = @character_set.rotate(shifts.a_shift)
        a_letters << @character_set[0]
      else
        a_letters << letter
      end
    end
    message_array[1].each do |letter|
      if @character_set.include?(letter)
        until @character_set[0] == letter
          @character_set = @character_set.rotate
        end
        @character_set = @character_set.rotate(shifts.b_shift)
        b_letters << @character_set[0]
      else
        b_letters << letter
      end
    end
    message_array[2].each do |letter|
      if @character_set.include?(letter)
        until @character_set[0] == letter
          @character_set = @character_set.rotate
        end
        @character_set = @character_set.rotate(shifts.c_shift)
        c_letters << @character_set[0]
      else
        c_letters << letter
      end
    end
    message_array[3].each do |letter|
      if @character_set.include?(letter)
        until @character_set[0] == letter
          @character_set = @character_set.rotate
        end
        @character_set = @character_set.rotate(shifts.d_shift)
        d_letters << @character_set[0]
      else
        d_letters << letter
      end
    end
    encrypted_array
  end

  def message_as_string(type)
    if type == "encrypted"
      return encrypted_message_as_array[0].zip(encrypted_message_as_array[1]).zip(encrypted_message_as_array[2]).zip(encrypted_message_as_array[3]).join
    elsif type == "decrypted"
      return decrypted_message_as_array[0].zip(decrypted_message_as_array[1]).zip(decrypted_message_as_array[2]).zip(decrypted_message_as_array[3]).join
    end
  end

  # def decrypted_message_as_string
  #   decrypted_array = decrypted_message_as_array
  #   decrypted_array[0].zip(decrypted_array[1]).zip(decrypted_array[2]).zip(decrypted_array[3]).join
  # end

  # def encrypted_message_as_string
  #   encrypted_array = encrypted_message_as_array
  #   encrypted_array[0].zip(encrypted_array[1]).zip(encrypted_array[2]).zip(encrypted_array[3]).join
  # end

  def decrypted_message_as_array
    message_array = prep_message_for_shifts
    a_letters = []; b_letters = []; c_letters = []; d_letters = []
    decrypted_array = [a_letters, b_letters, c_letters, d_letters]
    message_array[0].each do |letter|
      if @character_set.include?(letter)
        until @character_set[0] == letter
          @character_set = @character_set.rotate
        end
        @character_set = @character_set.rotate(shifts.a_shift * -1)
        a_letters << @character_set[0]
      else
        a_letters << letter
      end
    end
    message_array[1].each do |letter|
      if @character_set.include?(letter)
        until @character_set[0] == letter
          @character_set = @character_set.rotate
        end
        @character_set = @character_set.rotate(shifts.b_shift * -1)
        b_letters << @character_set[0]
      else
        b_letters << letter
      end
    end
    message_array[2].each do |letter|
      if @character_set.include?(letter)
        until @character_set[0] == letter
          @character_set = @character_set.rotate
        end
        @character_set = @character_set.rotate(shifts.c_shift * -1)
        c_letters << @character_set[0]
      else
        c_letters << letter
      end
    end
    message_array[3].each do |letter|
      if @character_set.include?(letter)
        until @character_set[0] == letter
          @character_set = @character_set.rotate
        end
        @character_set = @character_set.rotate(shifts.d_shift * -1)
        d_letters << @character_set[0]
      else
        d_letters << letter
      end
    end
    decrypted_array
  end


  def calculate_shifts
  # Offset is already known due to date being provided and the last 4 characters will always be `_end`.
  # With knowing the offset and being able to calculate the shift due to the last 4 known characters,
  # we can use math to figure out the original key for the solution.
  # Take the shifts in increments of (shift + 27) and then subtract the offsets from those.
  # Using the result, compare the increments until a 5 digit key can be created using the overlaps
    # a,b,c,d = prep_message_for_shifts
    # character_shifts = {a_shift: a, b_shift: b, c_shift: c, d_shift: d}
    starting_message = @message.split("")
    last_4_of_message = starting_message[-4..-1]
    known_info = [" ","e","n","d"]
    index_reducer = 3
    # CALCULATES THE SHIFTS USING THE "_END" AS KNOWN INFO
    until known_info.empty?
      if (starting_message.length - index_reducer) % 4 == 1
        #starts with a_shift
        if @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first) < 0
          @shifts.a_shift = ((@character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)) + 27)
        else
          @shifts.a_shift = @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)
        end
        last_4_of_message.shift && known_info.shift && index_reducer -= 1
        # @shifts.a_offset
      elsif (starting_message.length - index_reducer) % 4 == 2
        #starts with b_shift
        if @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first) < 0
          @shifts.b_shift = ((@character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)) + 27)
        else
          @shifts.b_shift = @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)
        end
        last_4_of_message.shift && known_info.shift && index_reducer -= 1
        # @shifts.b_offset
      elsif (starting_message.length - index_reducer) % 4 == 3
        #starts with c_shift
        if @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first) < 0
          @shifts.c_shift = ((@character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)) + 27)
        else
          @shifts.c_shift = @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)
        end
        last_4_of_message.shift && known_info.shift && index_reducer -= 1
        # @shifts.c_offset
      elsif (starting_message.length - index_reducer) % 4 == 0
        #starts with d_shift
        if @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first) < 0
          @shifts.d_shift = ((@character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)) + 27)
        else
          @shifts.d_shift = @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)
        end
        last_4_of_message.shift && known_info.shift && index_reducer -= 1
        # @shifts.d_offset
      end
    end

    # CALCULATES THE KEY USING THE KNOWN OFFSETS AND SHIFTS
    shifts.a_key = (shifts.a_shift - shifts.a_offset).to_s.rjust(2, "0")
    shifts.b_key = (shifts.b_shift - shifts.b_offset).to_s.rjust(2, "0")
    shifts.c_key = (shifts.c_shift - shifts.c_offset).to_s.rjust(2, "0")
    shifts.d_key = (shifts.d_shift - shifts.d_offset).to_s.rjust(2, "0")
  end

  def crack_encryption
    calculate_shifts
    @key = shifts.get_valid_key
    message_as_string("decrypted")
  end

end
