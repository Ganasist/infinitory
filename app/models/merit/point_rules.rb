module Merit
  class PointRules
    include Merit::PointRulesMethods
    def initialize
      score 1, on: ['messages#create']
      score 2, on: ['reagents#update', 'devices#update', 'bookings#update']
      score 3, on: ['reagents#create', 'devices#create', 'bookings#create']
      score 4, on: ['reagents#clone', 'devices#clone']
      score 5, on: ['reagents#destroy', 'devices#destroy', 'bookings#destroy']

      %w(serial? location? description? product_url? purchasing_url?).each do |attribute|
        score 2, on: ['reagents#update', 'devices#update'] do |item|
          item.method(attribute).call
        end
        score 3, on: ['reagents#create', 'devices#create'] do |item|
          item.method(attribute).call
        end
        score 4, on: ['reagents#clone', 'devices#clone'] do |item|
          item.method(attribute).call
        end
      end

      %w(icon? pdf?).each do |attribute|
        score 5, on: ['reagents#update', 'devices#update'] do |item|
          item.method(attribute).call
        end
        score 10, on: ['reagents#create', 'devices#create'] do |item|
          item.method(attribute).call
        end
        score 15, on: ['reagents#clone', 'devices#clone'] do |item|
          item.method(attribute).call
        end
      end

       %w(expiration? lot_number?).each do |attribute|
        score 2, on: 'reagents#update' do |item|
          item.method(attribute).call
        end
        score 3, on: 'reagents#create' do |item|
          item.method(attribute).call
        end
        score 4, on: 'reagents#clone' do |item|
          item.method(attribute).call
        end
      end

      score 2, on: ['reagents#update', 'devices#update'] do |item|
        item.price > 0
      end
      score 3, on: ['reagents#create', 'devices#create'] do |item|
        item.price > 0
      end
      score 4, on: ['reagents#clone', 'devices#clone'] do |item|
        item.price > 0
      end
    end
  end
end