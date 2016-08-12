class User < ApplicationRecord
  # Extensions
  rolify
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  after_initialize :setup, :if => :new_record?

  def setup
    set_default_role
  end

  def set_default_role
    add_role :normal
  end
end
