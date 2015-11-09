def login(email)
  visit admin_path
  fill_in :email, with: email
  fill_in :password, with: my_password
  click_button "Войти"
end

def my_password
  "mypassword"
end
