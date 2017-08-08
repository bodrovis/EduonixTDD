class CurrencyRate
  attr_reader :rates

  def initialize
    @rates = JSON.parse Net::HTTP.get(
        URI.parse('https://api.fixer.io/latest?symbols=USD,GBP')
    )
  end

  def usd
    @rates['rates']['USD']
  end
end