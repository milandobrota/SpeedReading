class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :contents, :through => :categorizations
end
