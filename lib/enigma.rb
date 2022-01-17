require 'date'
require_relative './cipher'
require_relative './shifts'

class Enigma

  def initialize
    @today = Date.today.strftime("%d%m%y")
    @random_key = (rand(0..99999)).to_s.rjust(5, "0")
  end

  def encrypt(message, key = @random_key, date = @today)
    cipher = Cipher.new(message, key, date)
    encrypted = {encryption: cipher.message_as_string("encrypted"),
                key: key,
                date: date}
  end

  def decrypt(ciphertext, key, date = @today)
    cipher = Cipher.new(ciphertext, key, date)
    decrypted = {decryption: cipher.message_as_string("decrypted"),
                key: key,
                date: date}
  end

  def crack(ciphertext, date = @today)
    cipher = Cipher.new(ciphertext, date)
    cracked = {decryption: cipher.crack_encryption,
              key: cipher.key,
              date: date}
  end
end
