require 'rails_helper'

describe "Accessing pages" do
  context "when not logged in" do
    it "restricts access main admin page" do
      visit admin_path
      expect(page).to have_button("Войти")
    end

    it "restricts access to manage photos and categories" do
      visit new_main_page_photo_path
      expect(page).to have_button("Войти")
      expect(page).not_to have_content("Добавить фото на главную страницу")

      visit new_portfolio_photo_path
      expect(page).to have_button("Войти")
      expect(page).not_to have_content("Добавить фото в портфолио")

      visit new_category_path
      expect(page).to have_button("Войти")
      expect(page).not_to have_content("Добавить новую категорию")
    end
  end

  let(:user) { create :user }

  context "when logged in" do
    before do
      login(user.email)
    end

    it "grants access to admin panel" do
      visit admin_path
      expect(page).to have_content "Мой профиль"
      expect(page).to have_link "Выйти"
    end

    it "allows to manage photos and categories" do
      visit new_main_page_photo_path
      expect(page).to have_content("Добавить фото на главную страницу")

      visit new_portfolio_photo_path
      expect(page).to have_content("Добавить фото в портфолио")

      visit new_category_path
      expect(page).to have_content("Добавить новую категорию")
    end
  end
end
