Person.delete_all
Binder.delete_all

Person.create(:name => "Tony")
Binder.create(:name => "Tony's binder")

p1 = Person.find(1).first
b1  = Binder.find(1).first

