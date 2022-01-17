class Cipher

  attr_reader :message, :key, :date, :character_set, :shifts

  def initialize(message, key = "-00000", date)
    @message = message.downcase
    @key = key
    @date = date
    @character_set = ("a".."z").to_a << " "
    @shifts = Shifts.new(@key, @date)
  end

  def message_as_array
    @message.split("")
  end

  def prep_message_for_shifts
    original_message = message_as_array
    a_letters = []; b_letters = []; c_letters = []; d_letters = []
    until original_message.empty?
      a_letters << original_message[0]; b_letters << original_message[1]
      c_letters << original_message[2]; d_letters << original_message[3]
      4.times {original_message.shift}
    end
    prepped_hash = {A: a_letters, B: b_letters.compact, C: c_letters.compact, D: d_letters.compact}
  end

  def shifted_message_as_array(shift_direction)
    a_letters = []; b_letters = []; c_letters = []; d_letters = []
    prep_message_for_shifts.each_pair do |key, array|
      array.each do |char|
        if @character_set.include?(char)
          (@character_set = @character_set.rotate) until @character_set[0] == char
          (@character_set = @character_set.rotate(shifts.a_shift * shift_direction)) && (a_letters << @character_set[0]) if key == :A
          (@character_set = @character_set.rotate(shifts.b_shift * shift_direction)) && (b_letters << @character_set[0]) if key == :B
          (@character_set = @character_set.rotate(shifts.c_shift * shift_direction)) && (c_letters << @character_set[0]) if key == :C
          (@character_set = @character_set.rotate(shifts.d_shift * shift_direction)) && (d_letters << @character_set[0]) if key == :D
        else
          a_letters << char if key == :A; b_letters << char if key == :B
          c_letters << char if key == :C; d_letters << char if key == :D
        end
      end
    end
    transformed_array = [a_letters, b_letters, c_letters, d_letters]
  end

  def message_as_string(type)
    if type == "encrypted"
      return shifted_message_as_array(1)[0].zip(shifted_message_as_array(1)[1]).zip(shifted_message_as_array(1)[2]).zip(shifted_message_as_array(1)[3]).join
    elsif type == "decrypted"
      return shifted_message_as_array(-1)[0].zip(shifted_message_as_array(-1)[1]).zip(shifted_message_as_array(-1)[2]).zip(shifted_message_as_array(-1)[3]).join
    end
  end

  def calculate_shifts
  # Offset is already known due to date being provided and the last 4 characters will always be `_end`.
  # With knowing the offset and being able to calculate the shift due to the last 4 known characters,
  # we can use math to figure out the original key for the solution.
  # Take the shifts in increments of (shift + 27) and then subtract the offsets from those.
  # Using the result, compare the increments until a 5 digit key can be created using the overlaps
    last_4_of_message = message_as_array[-4..-1]
    known_info = [" ","e","n","d"]
    index_reducer = 3
    until known_info.empty?
      if (message_as_array.length - index_reducer) % 4 == 1
        if @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first) < 0
          @shifts.a_shift = ((@character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)) + 27)
        else
          @shifts.a_shift = @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)
        end
        last_4_of_message.shift && known_info.shift && index_reducer -= 1
      elsif (message_as_array.length - index_reducer) % 4 == 2
        if @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first) < 0
          @shifts.b_shift = ((@character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)) + 27)
        else
          @shifts.b_shift = @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)
        end
        last_4_of_message.shift && known_info.shift && index_reducer -= 1
      elsif (message_as_array.length - index_reducer) % 4 == 3
        if @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first) < 0
          @shifts.c_shift = ((@character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)) + 27)
        else
          @shifts.c_shift = @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)
        end
        last_4_of_message.shift && known_info.shift && index_reducer -= 1
      elsif (message_as_array.length - index_reducer) % 4 == 0
        if @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first) < 0
          @shifts.d_shift = ((@character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)) + 27)
        else
          @shifts.d_shift = @character_set.index(last_4_of_message.first) - @character_set.index(known_info.first)
        end
        last_4_of_message.shift && known_info.shift && index_reducer -= 1
      end
    end
  end

  def crack_encryption
    calculate_shifts
    shifts.crack_key_calculator
    @key = shifts.get_valid_key
    message_as_string("decrypted")
  end
end
