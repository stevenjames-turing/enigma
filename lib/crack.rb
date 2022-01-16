require './lib/enigma'

enigma = Enigma.new

encrypted_file = File.open(ARGV[0], "r")
cracked_file = File.open(ARGV[1], "w")
decryption_date = ARGV[2]

cracked_message = enigma.crack(encrypted_file.read.chomp, decryption_date)

cracked_file.write(cracked_message[:decryption])
cracked_file.close

puts "Created #{ARGV[1]} with the key #{cracked_message[:key]} and date #{cracked_message[:date]}"
