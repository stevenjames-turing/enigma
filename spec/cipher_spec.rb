require './lib/cipher'

RSpec.describe Cipher do

  let (:cipher) {Cipher.new}

  it 'exists' do
    expect(cipher).to be_instance_of Cipher
  end
end
