require './lib/enigma'

RSpec.describe Enigma do

  let (:enigma) {Enigma.new}

  it 'exists' do
    expect(enigma).to be_instance_of Enigma
  end
end
