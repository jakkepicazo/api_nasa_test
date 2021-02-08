require "uri"
require "net/http"
require "json"

def request(url,token = nil)
    url = URI("#{url}?sol=1000&api_key=#{token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
end

nasa_array = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos","qVOQFRUPzsRgkBdXaM2pxd2b6iOCQBkR3togl1r5")
 buid_web_page(nasa_array)