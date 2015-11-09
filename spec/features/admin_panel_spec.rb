require 'rails_helper'

describe "Admin panel" do
  let(:user) { create :user }

  before do
    login(user.email)
  end

  it "adds photos to the main page" do
    visit new_main_page_photo_path
    attach_file("Image", image_path)
    click_button "Create Main page photo"
    expect(page).to have_content("Фотография добавлена")

    visit root_path
    expect(page).to have_xpath(main_page_photo_xpath)
  end

  let!(:category) { create :category }

  it "adds photos to the portfolio page" do
    visit new_portfolio_photo_path
    attach_file("Image", image_path)
    select category.display_name, from: "Category"
    click_button "Create Portfolio photo"
    expect(page).to have_content("Фотография добавлена")

    visit portfolio_path
    expect(page).to have_xpath(portfolio_photo_xpath)
  end

  it "creates category" do
    display_name =  "Разное"
    visit new_category_path
    fill_in :category_display_name, with: display_name
    fill_in :category_name, with: "different"
    click_button "Create Category"
    expect(page).to have_content("Категория создана")
    expect(page).to have_content(display_name)
  end
end
