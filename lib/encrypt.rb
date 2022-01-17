require './lib/enigma'

enigma = Enigma.new

message_file = File.open(ARGV[0], "r")
encrypted_file = File.open(ARGV[1], "w")

encrypted_message = enigma.encrypt(message_file.read)

encrypted_file.write(encrypted_message[:encryption])
encrypted_file.close

puts "Created #{ARGV[1]} with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
