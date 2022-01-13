require './lib/shifts'

RSpec.describe Shifts do

  let (:shifts) {Shifts.new(key, date)}

  it 'exists' do
    shifts_object = Shifts.new("key", "date")
    expect(shifts_object).to be_instance_of Shifts
  end

end
