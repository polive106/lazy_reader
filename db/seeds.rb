# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "#"*30
puts "Destroying all articles in DB..."
Article.destroy_all
puts "Creating Sample Article --> Daft Punk..."
daft_punk = Article.new(
  url: "https://en.wikipedia.org/wiki/Daft_Punk",
  title: "Daft Punk",
  source: "wikipedia.com",
  content: 'Daft Punk (French pronunciation: ​[daft pœŋk]) were a French electronic music duo formed in 1993 in Paris by Guy-Manuel de Homem-Christo and Thomas Bangalter. Often considered one of the most influential acts in dance music history, they achieved popularity in the late 1990s as part of the French house movement. They also had success in the years following, combining elements of house music with funk, techno, disco, indie rock and pop. After Bangalter and Homem-Christo\'s indie rock band Darlin\' disbanded, they began experimenting with drum machines, synthesisers and the talk box. Their debut studio album Homework was released by Virgin Records in 1997 to positive reviews, backed by singles "Around the World" and "Da Funk". From 1999, they assumed robot personas with helmets, outfits and gloves for public appearances to preserve their identities; they made few media appearances.[1] They were managed from 1996 to 2008 by Pedro Winter, the head of Ed Banger Records. Daft Punk\'s second album, Discovery (2001), had further success, supported by hit singles "One More Time", "Digital Love" and "Harder, Better, Faster, Stronger". The album became the basis for an animated film, Interstella 5555, produced by Japanese animator Leiji Matsumoto. Daft Punk\'s third album, Human After All (2005), received mixed reviews, though the singles "Robot Rock" and "Technologic" achieved success in the United Kingdom. The duo directed their first film, Electroma, an avant-garde science fiction film, in 2006. They toured throughout 2006 and 2007 and released the live album Alive 2007, which won a Grammy Award for Best Electronic/Dance Album; the tour is credited for popularising dance music in North America. Daft Punk composed the score for the 2010 film Tron: Legacy. In 2013, Daft Punk left Virgin for Columbia Records and released their fourth album, Random Access Memories, to acclaim; lead single "Get Lucky" reached the top 10 in the charts of 32 countries. Random Access Memories won five Grammy Awards in 2014, including Album of the Year and Record of the Year for "Get Lucky". In 2016, Daft Punk gained their only number one on the Billboard Hot 100 with "Starboy", a collaboration with the Weeknd. Rolling Stone ranked them No. 12 on its list of the 20 Greatest Duos of All Time. They announced their split in February 2021.'
  )
daft_punk.save!
puts "#"*30


