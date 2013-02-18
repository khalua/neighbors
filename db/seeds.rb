Person.delete_all
Binder.delete_all

Person.create(:name => "Tony")
Binder.create(:name => "Tony's binder")

p1 = Person.find(1).first
b1  = Binder.find(1).first

Demographic.create(:state => 'no data found', :city => 'Sorry', :latitude => 40.697488, :longitude => -73.979681)
Demographic.create(:state => 'USA', :city => 'USA', :household_income => 44512, :single_family_home => 158400, :single_males => 14.646218, :single_females => 12.4578, :median_age => 36, :homes_with_kids => 31.36239, :owners => 66.2687, :renters => 33.7312, :latitude => 43.261206, :longitude => -82.705078 )