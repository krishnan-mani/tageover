RSpec.describe "date utility" do

  def pad_two_digits(foo)
    foo.to_s.rjust(2, '0')
  end

  it 'produces a date string' do
    require 'date'
    now = DateTime.now
    date_str = now.strftime('%Y-%m-%d')
    expect(date_str).to eql "#{now.year}-#{pad_two_digits(now.month)}-#{pad_two_digits(now.day)}"
  end

end