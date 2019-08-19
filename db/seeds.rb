# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Manger.create(name:"مدير المنشاءة")
# User.create(username:"admin", password:"admin", role_type:'مدير', is_default: true)
# User.create(username:"user", password:"user", role_type:'مستخدم', is_default: false)
Marketer.all.map{|m| m.update_columns(for_him: 0) if m.for_him.nil? }
Delegate.all.map do |delegate|
  delegate.update_columns(for_him:0)if delegate.for_him.nil?
  delegate.update_columns(amount_of_box: 0) if delegate.amount_of_box.nil?
  delegate.update_columns(amount_of_gallon: 0)if delegate.amount_of_gallon.nil?
end