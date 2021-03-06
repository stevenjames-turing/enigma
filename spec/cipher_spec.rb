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
    expected = {A: ["h", "o", "r"], B: ["e", " ", "l"], C: ["l", "w", "d"], D: ["l", "o"]}
    expect(cipher.prep_message_for_shifts.keys.count).to eq(4)
    expect(cipher.prep_message_for_shifts).to eq(expected)
  end

  it 'can shift the characters and return encrypted message as array' do
    expected = [["k", "r", "u"], ["e", " ", "l"], ["d", "o", "w"], ["e", "h"]]
    expect(cipher.shifted_message_as_array(1)).to eq(expected)
  end

  it 'can turn encrypted array into string' do
    expect(cipher.message_as_string("encrypted")).to eq("keder ohulw")
  end

  it 'returns any characters not included in the character set as itself' do
    cipher_char_test_1 = Cipher.new("hello world!", "02715", "040895")
    cipher_char_test_2 = Cipher.new("!hell!o wo!rld", "02715", "040895")
    expected_1 = [["k", "r", "u"], ["e", " ", "l"], ["d", "o", "w"], ["e", "h", "!"]]
    expected_2 = [["!", "o", "z", "o"], ["h", "!", "o", "d"], ["x", "g", "!"], ["e", "t", "k"]]
    expect(cipher_char_test_1.shifted_message_as_array(1)).to eq(expected_1)
    expect(cipher_char_test_2.shifted_message_as_array(1)).to eq(expected_2)
  end
end
