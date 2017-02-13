require "sequel"
DB = Sequel.connect("postgres://localhost/sequel-single-table")

def format_money(numeric)
  format("$%0.2f", numeric)
end

result = DB[:menu_items].select do
  labor_calc = prep_time / 60.0 * 12
  profit_calc = menu_price - ingredient_cost - labor_calc
  [item, menu_price, ingredient_cost, labor_calc.as(labor), profit_calc.as(profit)]
end

result.each do |row|
  puts row[:item]
  puts "menu price: #{format_money(row[:menu_price])}"
  puts "ingredient cost: #{format_money(row[:ingredient_cost])}"
  puts "labor: #{format_money(row[:labor])}"
  puts "profit: #{format_money(row[:profit])}"
  puts
end
# def format_money(numeric)
#   format("$%0.2f", numeric)
# end

# result = DB[:menu_items].select do
#   labor_calc = prep_time / 60.0 * 12
#   profit_calc = menu_price - ingredient_cost - labor_calc
#   [item, menu_price, ingredient_cost, labor_calc.as(labor), profit_calc.as(profit)]
# end

# result.each do |row| 
#   puts row[:item]
#   puts "menu price: #{format_money(row[:menu_price])}"
#   puts "ingredient cost: #{format_money(row[:ingredient_cost])}"
#   puts "labor: #{format_money(row[:labor])}"
#   puts "profit: #{format_money(row[:profit])}"
# end

# def create_database
#   system('dropdb', '--if-exists', 'billing2')
#   system('createdb', 'billing2')
# end

# def create_customers
#   DB.create_table(:customers) do
#     primary_key :id
#     String      :name, text: true, null: false
#     String      :payment_token, fixed: true, size: 8, null: false, unique: true

#     constraint(:customers_payment_token_pattern_constraint) do
#       payment_token =~ /\A[A-Z]{8}\z/
#     end
#   end
# end

# def insert_customer_row(name, payment_token)
#   DB[:customers].insert(name: name, payment_token: payment_token)
# end

# def insert_customers
#   insert_customer_row('Pat Johnson', 'XHGOAHEQ')
#   insert_customer_row('Nancy Monreal', 'JKWQPJKL')
#   insert_customer_row('Lynn Blake', 'KLZXWEEE')
#   insert_customer_row('Chen Ke-Hua', 'KWETYCVX')
#   insert_customer_row('Scott Lakso', 'UUEAPQPS')
#   insert_customer_row('Jim Pornot', 'XKJEYAZA')
# end

# def create_services
#   DB.create_table(:services) do
#     primary_key :id
#     String      :description, text: true, null: false
#     BigDecimal  :price, size: [10, 2], null: false

#     constraint(:services_price_non_negative_constraint) { price >= 0.00 }
#   end
# end

# def insert_service_row(description, price)
#   DB[:services].insert(description: description, price: price)
# end

# def insert_services
#   insert_service_row('Unix Hosting', 5.95)
#   insert_service_row('DNS', 4.95)
#   insert_service_row('Whois Registration', 1.95)
#   insert_service_row('High Bandwidth', 15.00)
#   insert_service_row('Business Support', 250.00)
#   insert_service_row('Dedicated Hosting', 50.00)
#   insert_service_row('Bulk Email', 250.00)
#   insert_service_row('One-to-one Training', 999.00)
# end

# def create_customers_services
#   DB.create_table(:customers_services) do
#     primary_key :id
#     foreign_key :customer_id, :customers, on_delete: :cascade
#     foreign_key :service_id, :services
#   end
# end

# def insert_customer_service_row(customer_id, service_id)
#   DB[:customers_services].insert(customer_id: customer_id,
#                                  service_id: service_id)
# end

# # rubocop:disable Metrics/MethodLength
# def insert_customers_services
#   insert_customer_service_row(1, 1) # Pat Johnson/Unix Hosting
#   insert_customer_service_row(1, 2) #            /DNS
#   insert_customer_service_row(1, 3) #            /Whois Registration
#   insert_customer_service_row(3, 1) # Lynn Blake/Unix Hosting
#   insert_customer_service_row(3, 2) #           /DNS
#   insert_customer_service_row(3, 3) #           /Whois Registration
#   insert_customer_service_row(3, 4) #           /High Bandwidth
#   insert_customer_service_row(3, 5) #           /Business Support
#   insert_customer_service_row(4, 1) # Chen Ke-Hua/Unix Hosting
#   insert_customer_service_row(4, 4) #            /High Bandwidth
#   insert_customer_service_row(5, 1) # Scott Lakso/Unix Hosting
#   insert_customer_service_row(5, 2) #            /DNS
#   insert_customer_service_row(5, 6) #            /Dedicated Hosting
#   insert_customer_service_row(6, 1) # Jim Pornot/Unix Hosting
#   insert_customer_service_row(6, 6) #           /Dedicated Hosting
#   insert_customer_service_row(6, 7) #           /Bulk Email
# end
# # rubocop:enable Metrics/MethodLength

# DB = Sequel.connect "postgres://localhost/billing2"

# create_database

# create_customers
# insert_customers

# create_services
# insert_services

# create_customers_services
# insert_customers_services

