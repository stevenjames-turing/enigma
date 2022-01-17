require './lib/enigma'

enigma = Enigma.new

encrypted_file = File.open(ARGV[0], "r")
decrypted_file = File.open(ARGV[1], "w")
decryption_key = ARGV[2]
decryption_date = ARGV[3]

decrypted_message = enigma.decrypt(encrypted_file.read, decryption_key, decryption_date)

decrypted_file.write(decrypted_message[:decryption])
decrypted_file.close

puts "Created #{ARGV[1]} with the key #{decrypted_message[:key]} and date #{decrypted_message[:date]}"
