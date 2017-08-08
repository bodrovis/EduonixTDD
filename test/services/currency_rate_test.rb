require 'test_helper'

describe CurrencyRate do
  it 'should allow to fetch currency rates' do
    VCR.use_cassette("currency_rates") do
      currency_rates = CurrencyRate.new
      assert_equal 1.1814, currency_rates.usd
    end
  end
end