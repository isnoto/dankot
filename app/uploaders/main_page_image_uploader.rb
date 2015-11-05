class MainPageImageUploader < ImageUploaderBase
  process :create_main_page_version

  def create_main_page_version
    landscape? ? resize_to_fit(573, 382) : resize_to_fill(254, 382)
  end
end
