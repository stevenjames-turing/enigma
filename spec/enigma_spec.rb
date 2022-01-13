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



end
