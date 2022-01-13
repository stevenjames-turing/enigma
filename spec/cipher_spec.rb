require './lib/cipher'

RSpec.describe Cipher do

  let (:cipher) {Cipher.new("hello world", "02715", "040895")}

  it 'exists' do
    expect(cipher).to be_instance_of Cipher
  end

  it 'initializes with a message, key, and date' do
    expect(cipher.message).to eq("hello world")
    expect(cipher.key).to eq("02715")
    expect(cipher.date).to eq("040895")
  end
end
