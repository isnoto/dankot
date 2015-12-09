class PortfolioImageUploader < ImageUploaderBase
  version :portfolio do
    process :create_portfolio_version
    process :optimize
  end

  version :zoom do
    process :create_zoom_version
    process :optimize
  end

  def create_portfolio_version
    landscape? ? resize_to_fit(300, 200) : resize_to_fill(300, 450)
  end

  def create_zoom_version
    landscape? ? resize_to_fit(604, 402) : resize_to_fill(402, 604)
  end
end
