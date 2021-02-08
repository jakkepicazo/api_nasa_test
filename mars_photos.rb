require "uri"
require "net/http"
require "json"

def request(url,token = nil)
    url = URI("#{url}?sol=2&api_key=#{token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
end

def buid_web_page(photos_data)
    File.open('mars_index.html', 'w') do |file|
        photos = photos_data["photos"]
        file.puts "<html>"
        file.puts "<head>"
        file.puts "<h1 style='text-align:center'>Mars Rover Photos</h1>"
        file.puts "</head>"
        file.puts "<body>"
        file.puts "<ul>"
        file.puts "<h2>Photos Sol 2</h2>"
        photos.each do |photo|
            file.puts "<li><img src='#{photo["img_src"]}'width='200px'></li>"
            file.puts "</ul>"
        end
        file.puts "</body>"
        file.puts "</html>"
        
    end
end 

def photos_count(photos)
    photos_hash = Hash.new(0)
    photos["photos"].each do |info|
        photos_hash[info["camera"]["name"]] += 1
    end
    photos_hash.each do |key, value|
        puts "#{key} number of photos: #{value}"
    end
end


nasa_array = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos","qVOQFRUPzsRgkBdXaM2pxd2b6iOCQBkR3togl1r5")
buid_web_page(nasa_array)
photos_count(nasa_array)