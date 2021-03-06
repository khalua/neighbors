# == Schema Information
#
# Table name: binders
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class Binder < ActiveRecord::Base
  attr_accessible :name, :description, :demographic_ids
  has_and_belongs_to_many  :demographics
  belongs_to  :people
end
