# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Country.create(name: 'السعوديه')
# Country.create(name: 'الامارات')
# Country.create(name: 'البحرين')
# Country.create(name: 'عمان')
# Country.create(name: 'الكويت')
# Country.create(name: 'اليمن')
# Country.create(name: 'الاردن')
# Country.create(name: 'قطر')
# Country.create(name: 'مصر')
# Country.create(name: 'العراق')

# Country.all.each do |country|
#   Manger.create(name:"مدير المنشاءة", country_id: country.id)
#   User.create(username:"admin", password:"admin", role_type:'مدير', is_default: true, country_id: country.id)
#   User.create(username:"user", password:"user", role_type:'مستخدم', is_default: false, country_id: country.id)
# end
# Delegate.all.map{|delegate| delegate.update(country_id: 1) if delegate.country_id.nil? }
# Marketer.all.map{|marketer| marketer.update(country_id: 1) if marketer.country_id.nil? }
# Assistant.all.map{|assistant| assistant.update(country_id: 1) if assistant.country_id.nil? }
# Delivery.all.map{|delivery| delivery.update(country_id: 1) if delivery.country_id.nil? }
# User.all.map{|user| user.update(country_id: 1) if user.country_id.nil? }
# Manger.all.map{|record| record.update(country_id: 1) if record.country_id.nil? }
# BankTransfer.all.map{|record| record.update(country_id: 1) if record.country_id.nil? }
# MangerDiscount.all.map{|record| record.update(country_id: 1) if record.country_id.nil? }
# ProductDiscount.all.map{|record| record.update(country_id: 1) if record.country_id.nil? }
# SalesOperation.all.map{|sales_operation| sales_operation.update(country_id: 1) if sales_operation.country_id.nil? }
# Manger.find(5).delete
# Marketer.all.map{|m| m.update_columns(for_him: 7) if m.for_him.nil? }
# Delegate.all.map do |delegate|
#   delegate.update_columns(for_him:0)if delegate.for_him.nil?
#   delegate.update_columns(amount_of_box: 0) if delegate.amount_of_box.nil?
#   delegate.update_columns(amount_of_gallon: 0)if delegate.amount_of_gallon.nil?
# end

# su_country = Country.find(1)
# su_country.bank_transfers.each{|record| record.destroy  }
# su_country.manger_discounts.each{|record| record.destroy  }
# su_country.product_discounts.each{|record| record.destroy  }
# su_country.sales_operations.each{|sales_operation| sales_operation.destroy }
# su_country.deliveries.each{|delivery| delivery.destroy }
# SalesOperation.delete_all
# BankTransfer.delete_all
# MangerDiscount.delete_all
# BankTransfer.delete_all
# Delivery.delete_all
# Delegate.all.update_all(amount_of_box: 0, amount_of_gallon: 0, for_him: 0)
# Marketer.all.update_all(for_him: 0)
# Assistant.all.update_all(for_him: 0, his_amount: 0)
# Manger.all.update_all(final_manager_amount: 0, for_him:0, to_him: 0)

# Country.all.each do |country|
#   next if country.name == 'السعوديه'
#   country.bank_transfers.each{|record| record.destroy  }
#   country.manger_discounts.each{|record| record.destroy  }
#   country.product_discounts.each{|record| record.destroy  }
#   country.sales_operations.each{|sales_operation| sales_operation.destroy }
#   country.deliveries.each{|delivery| delivery.destroy }
#   country.delegates.each{|delivery| delivery.destroy }
#   country.marketers.each{|delivery| delivery.destroy }
#   country.assistants.each{|delivery| delivery.destroy }
# end