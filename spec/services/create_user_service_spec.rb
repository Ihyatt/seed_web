require 'rails_helper'

RSpec.describe CreateUserService do

  it "should create a valid admin user" do
    email = FactoryGirl.generate(:email)
    
    user = CreateUserService.create_admin_user(email, FactoryGirl.generate(:password))

    expect(user.valid?).to eq(true)
    expect(user.persisted?).to eq(true)
    expect(user.has_role?(:admin)).to eq(true)
  end

  it "should create a valid user" do
    email = FactoryGirl.generate(:email)
    user = CreateUserService.create_user(email, FactoryGirl.generate(:password))

    expect(user.valid?).to eq(true)
    expect(user.persisted?).to eq(true)
  end


end
