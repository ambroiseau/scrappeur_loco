require 'rubygems'
require 'nokogiri'         
require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage(url)
  doc = Nokogiri::HTML(open(url))
  doc.css('td')[7].text 
end

get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/95/vaureal.html")

  
def get_all_the_urls_of_val_doise_townhalls(url)
  doc = Nokogiri::HTML(open(url))
  links = doc.css("a[class=lientxt]")

  array_final = Array.new

  urls = links.each {|url|    
    hash_ville_mail = Hash.new
    hash_ville_mail['ville'] = url.text
    hash_ville_mail ['email'] = get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/"+url['href'][1..-1])
    array_final.push(hash_ville_mail)
    }
    print array_final
end 

get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html")

