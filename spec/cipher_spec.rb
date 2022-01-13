require_relative './spec_helper'

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

  it 'has a default character set' do
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
                "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    expect(cipher.character_set).to eq(expected)
  end

  it 'will always use a message with lowercase letters' do
    cipher_captest = Cipher.new("hElLo WoRlD", "02715", "040895")
    expect(cipher_captest.message).to eq("hello world")
  end

  it 'can split the message into arrays to prepare for shifts' do
    expect(cipher.prep_message_for_shifts.count).to eq(4)
  end

  it 'can shift the characters and return encrypted message as array' do
    # expected = ["k","e","d","e","r"," ","o","h","u","l","w"]
    expected = ["k","r","u","e"," ","l","d","o","w","e","h"]
    expect(cipher.encrypted_message_as_array).to eq(expected)
  end
end
