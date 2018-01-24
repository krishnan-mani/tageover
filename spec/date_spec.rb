RSpec.describe "date utilities" do

  def pad_two_digits(foo)
    foo.to_s.rjust(2, '0')
  end

  it 'produces a date string' do
    require 'date'
    now = Date.today
    date_str = now.strftime('%Y-%m-%d')
    expected_date_str = "#{now.year}-#{pad_two_digits(now.month)}-#{pad_two_digits(now.day)}"
    expect(date_str).to eq expected_date_str
  end

end