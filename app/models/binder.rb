# == Schema Information
#
# Table name: binders
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Binder < ActiveRecord::Base
  attr_accessible :name
  has_many  :demographics
end
