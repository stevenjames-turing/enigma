require 'date'
require_relative './cipher'
require_relative './shifts'

class Enigma

  def initialize
  end

  def encrypt(message, key, date)
    cipher = Cipher.new(message, key, date)
    encrypted = {encryption: cipher.encrypted_message_as_string,
                key: key,
                date: date}
  end

end
