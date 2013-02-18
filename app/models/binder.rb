# == Schema Information
#
# Table name: binders
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  person_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class Binder < ActiveRecord::Base
  attr_accessible :name, :description
  has_many  :demographics
  belongs_to  :people
end
