# == Schema Information
#
# Table name: demographics
#
#  id                 :integer          not null, primary key
#  state              :string(255)
#  city               :string(255)
#  household_income   :float
#  single_family_home :float
#  single_males       :float
#  single_females     :float
#  median_age         :integer
#  homes_with_kids    :float
#  owners             :float
#  renters            :float
#  latitude           :float
#  longitude          :float
#  binder_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Demographic < ActiveRecord::Base
  attr_accessible :state, :city, :household_income, :single_family_home, :single_males, :single_females, :median_age, :homes_with_kids, :owners, :renters, :latitude, :longitude, :binder_id
  belongs_to  :binder
end
