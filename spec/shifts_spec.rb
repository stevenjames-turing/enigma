require './lib/shifts'

RSpec.describe Shifts do

  let (:shifts) {Shifts.new(key, date)}
  let (:shifts_object) {Shifts.new("02715", "040895")}

  it 'exists' do
    expect(shifts_object).to be_instance_of Shifts
  end

  it 'uses the key passed as argument to create a,b,c,d keys' do
    expect(shifts_object.a_key).to eq(02)
    expect(shifts_object.b_key).to eq(27)
    expect(shifts_object.c_key).to eq(71)
    expect(shifts_object.d_key).to eq(15)
  end

  it 'uses the date passed as argument to create a,b,c,d offsets' do
    expect(shifts_object.offset).to eq("1025")
    expect(shifts_object.a_offset).to eq(1)
    expect(shifts_object.b_offset).to eq(0)
    expect(shifts_object.c_offset).to eq(2)
    expect(shifts_object.d_offset).to eq(5)
  end

end
