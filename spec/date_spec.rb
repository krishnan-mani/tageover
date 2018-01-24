require 'date'

RSpec.describe "date utilities" do

  def pad_two_digits(foo)
    foo.to_s.rjust(2, '0')
  end

  context "date formatting" do

    it 'produces a date string' do
      now = Date.today
      date_str = now.strftime('%Y-%m-%d')
      expected_date_str = "#{now.year}-#{pad_two_digits(now.month)}-#{pad_two_digits(now.day)}"
      expect(date_str).to eq expected_date_str
    end

  end

  context "date validation" do

    it 'validates the date string format' do
      date_str = '2018-01-25'
      date = Date.strptime(date_str)
      expect([date.year, date.month, date.day]).to eq [2018, 1, 25]
    end

    it 'raises an error for invalid date string format' do
      invalid_date_str = '2018-02-31'
      expect { Date.strptime(invalid_date_str) }.to raise_error(ArgumentError)
    end

  end

end