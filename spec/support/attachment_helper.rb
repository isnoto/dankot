def upload_image
  Rack::Test::UploadedFile.new(File.join(image_path))
end

def image_path
  Rails.root + "spec/fixtures/images/1.jpg"
end

def main_page_photo_xpath
  "//*[@id=\"gallery\"]/div[1]/div[1]/img"
end

def portfolio_photo_xpath
  "//*[@id=\"gallery-inner\"]/div[2]/img"
end
