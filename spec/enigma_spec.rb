require_relative './spec_helper'

RSpec.describe Enigma do

  let (:enigma) {Enigma.new}

  it 'exists' do
    expect(enigma).to be_instance_of Enigma
  end

  it 'can encrypt a message with a key and date' do
    expected = {encryption: "keder ohulw",
                key: "02715",
                date: "040895"}

    expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
  end

  it 'can encrypt a message with only a key (using today as date)' do
    expected = {encryption: "nmjduhugxtb",
                key: "02715",
                date: Date.today.strftime("%d%m%y")}

    expect(enigma.encrypt("hello world", "02715")).to eq(expected)
  end

  it 'can encrypt a message generating a random key and using today as date' do
    expect(enigma.encrypt("hello world")).to_not eq nil
    expect(enigma.encrypt("hello world")[:key].length).to eq(5)
    expect(enigma.encrypt("hello world")[:encryption].length).to eq(11)
    expect(enigma.encrypt("hello world")[:encryption].length).to_not eq("hello world")
    expect(enigma.encrypt("hello world")[:date]).to eq(Date.today.strftime("%d%m%y"))
  end

  it 'can *decrypt* a message with a key and date' do
    expected = {decryption: "hello world",
                key: "02715",
                date: "040895"}

    expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
  end

  it 'can *decrypt* a message with only a key (using today as date)' do
    encrypted = {encryption: "nmjduhugxtb",
      key: "02715",
      date: Date.today.strftime("%d%m%y")}
      
    expected = {decryption: "hello world",
      key: "02715",
      date: "040895"}

    expect(enigma.decrypt(encrypted[:encryption], "02715")).to eq(expected)
  end



end
