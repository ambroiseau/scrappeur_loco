require 'rubygems'
require 'nokogiri'         
require 'open-uri'
require 'pry'


def get_the_email(url)
    page = Nokogiri::HTML(open(url))
    email = page.xpath('//*[@id="b1"]/ul[2]/li[1]/ul/li/a').text
    email
end #ici je récupère tous les urls de chaque page où se trouve l'adresse email de chaque député


def get_the_names(url) #puis on va chercher à ranger tout ça proprement...
  doc = Nokogiri::HTML(open(url))
  div_classes = doc.xpath("//div[@class='list_table']")
  all_a = div_classes.css('a')

  array_final = Array.new #le array final qui contiendratous nos hashs

  all_a.each{|element| #grâce à cette boucle qui prend nos trois éléments du hash en compte
    deputy = Hash.new #nous créons le hash qui va contenir les trois éléments
    url = 'https://nosdeputes.fr'+element["href"]
    email = get_the_email(url) #les mails récupérés dans la méthode précédente
    noms = element.css(".list_nom").text.strip!.split(", ") #les noms que nous nettoyons grâce à strip et que nous splittons pour les obtenir first_name +last_name dans les lignes qui suivent
    puts "attendez quelques minutes ... : )"
    deputy['first_name']=noms[1]
    deputy['last_name']= noms[0]
    deputy['email']= email
    array_final.push(deputy)#on push enfin nos hash deputy dans l'array final créé avant la boucle
  }
    
    print array_final

end 

get_the_names("https://www.nosdeputes.fr/deputes")



