require 'date'
require_relative './cipher'
require_relative './shifts'

class Enigma

  def initialize
    @today = Date.today.strftime("%d%m%y")
  end

  def encrypt(message, key, date = @today)
    cipher = Cipher.new(message, key, date)
    encrypted = {encryption: cipher.encrypted_message_as_string,
                key: key,
                date: date}
  end

end
