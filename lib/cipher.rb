class Cipher

  attr_reader :message, :key, :date, :character_set

  def initialize(message, key, date)
    @message = message.downcase
    @key = key
    @date = date
    @character_set = ("a".."z").to_a << " "
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

  
end
