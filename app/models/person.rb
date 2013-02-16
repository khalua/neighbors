class Person < ActiveRecord::Base
  attr_accessible :name
  has_many  :binders
end