class ImageUploaderBase < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include Piet::CarrierWaveExtension

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :create_thumb_version
    process :optimize
  end

  def create_thumb_version
    landscape? ? resize_to_fit(290, 290) : resize_to_fit(200, 200)
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  private

  def dimensions
    img = MiniMagick::Image.open(current_path)
    { width: img.width, height: img.height }
  end

  def landscape?
    dimensions[:width] > dimensions[:height]
  end
end
