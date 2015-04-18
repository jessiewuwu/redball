require 'httparty'

def get_data

  response = HTTParty.get('https://www.googleapis.com/customsearch/v1?cx=016871532285775593244%3Ahitwjirk3ac&q=dog%20transparent%20gif&searchType=image&num=10&start=11&key=AIzaSyAy1FwWb_llGer7CJZk65r63ZidHFqdJ9Q')
  items = response["items"]
  items.map{|item| item["link"] }
end


#["http://www.petparadisesd.com/files/QuickSiteImages/Jumping_Dog_Transparent.gif", "http://38.media.tumblr.com/945fbc4c3ed929132898898aec615210/tumblr_mnkpnjNpDn1qehrn4o1_400.png", "https://33.media.tumblr.com/4fbb61f48f4c5cfa451a88e14f6579e7/tumblr_mwwh9w2vJf1s6294bo1_400.gif", "http://i.imgur.com/ZtgHoaE.gif", "https://33.media.tumblr.com/d2c8354c4159407804910207dc13c9eb/tumblr_n3hgaa9wmz1so0ukuo1_500.gif", "http://dogwalkerdirectory.co.uk/wp-content/uploads/2012/01/dog_6_transparent.png", "http://25.media.tumblr.com/tumblr_m8xqvfwIK41qfqgb9o1_500.gif", "http://media.giphy.com/media/r3tLH9DJH9OKc/giphy.gif", "http://webyippie.com/png.imageextra.com/png_files/dog.png", "http://gallery.yopriceville.com/downloadfullsize/send/4811"]
