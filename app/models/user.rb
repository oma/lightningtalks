class User < ActiveRecord::Base
  has_many :talks
  has_many :comments
end
