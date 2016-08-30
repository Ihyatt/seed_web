class CreateUserService

  def self.create_user(email, password)
    user = User.where(:email => email).first
    if user.nil?
      user = User.new(email: email)
    end
    user.password = user.password_confirmation = password
    user.save

    return user
  end

  def self.create_admin_user(email, password)
    user = create_user(email, password)

    user.add_role :admin
    user.save
    puts 'admin: ' << user.email

    return user
  end
end
