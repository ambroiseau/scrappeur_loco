
require 'rubygems'
require 'nokogiri'         
require 'open-uri'
require 'pry'


def crypto_and_price(url)

  array_crypto = Array.new
  array_price = Array.new

  page = Nokogiri::HTML(open(url))
  crypto = page.css("a[class='currency-name-container link-secondary']")  
  taux = page.css("td[data-timespan='1h']")

  crypto.each {|crypto_name|    
    hash_crypto = Array.new
    hash_crypto = crypto_name.text
    array_crypto.push(hash_crypto)
    }

  taux.each {|crypto_price|    
    hash_crypto = Array.new
    hash_crypto = crypto_price.text
    array_price.push(hash_crypto)
    }

  
  print tableau = [(array_crypto).zip(array_price)]

end


crypto_and_price("https://coinmarketcap.com/all/views/all/")

