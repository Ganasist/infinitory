module Merit
  class PointRules
    include Merit::PointRulesMethods
    def initialize
      score 1, on: ['messages#create']

      score 2, on: ['reagents#update', 'devices#update', 'bookings#update']
      # %w(serial location description product_url purchasing_url).each do |attribute|
      #   score 2, on: ['reagents#update', 'devices#update'] do |item|
      #     item.attribute.present?
      #   end
      # end
      score 2, on: 'reagents#update' do |item|
        item.expiration.present?
      end
      score 2, on: 'reagents#update' do |item|
        item.lot_number.present?
      end
      score 2, on: 'reagents#update' do |item|
        item.quantity.present?
      end
      score 2, on: ['reagents#update', 'devices#update'] do |item|
        item.serial.present?
      end
      score 2, on: ['reagents#update', 'devices#update'] do |item|
        item.location.present?
      end
      score 2, on: ['reagents#update', 'devices#update'] do |item|
        item.description.present?
      end
      score 2, on: ['reagents#update', 'devices#update'] do |item|
        item.price > 0
      end
      score 2, on: ['reagents#update', 'devices#update'] do |item|
        item.product_url.present?
      end
      score 2, on: ['reagents#update', 'devices#update'] do |item|
        item.purchasing_url.present?
      end
      score 5, on: ['reagents#update', 'devices#update'] do |item|
        item.shared?
      end
      # %w(icon pdf).each do |attribute|
      #   score 5, on: ['reagents#update', 'devices#update'] do |item|
      #     item.attribute.present?
      #   end
      # end
      score 5, on: ['reagents#update', 'devices#update'] do |item|
        item.icon.present?
      end
      score 5, on: ['reagents#update', 'devices#update'] do |item|
        item.pdf.present?
      end


      score 3, on: ['reagents#create', 'devices#create', 'bookings#create']
      # %w(serial location description product_url purchasing_url).each do |attribute|
      #   score 3, on: ['reagents#create', 'devices#create]' do |item|
      #     item.attribute.present?
      #   end
      # end
      score 3, on: 'reagents#create' do |item|
        item.expiration.present?
      end
      score 3, on: 'reagents#create' do |item|
        item.lot_number.present?
      end
      score 3, on: 'reagents#create' do |item|
        item.quantity.present?
      end
      score 3, on: ['reagents#create', 'devices#create'] do |item|
        item.serial.present?
      end
      score 3, on: ['reagents#create', 'devices#create'] do |item|
        item.location.present?
      end
      score 3, on: ['reagents#create', 'devices#create'] do |item|
        item.description.present?
      end
      score 3, on: ['reagents#create', 'devices#create'] do |item|
        item.price > 0
      end
      score 3, on: ['reagents#create', 'devices#create'] do |item|
        item.product_url.present?
      end
      score 3, on: ['reagents#create', 'devices#create'] do |item|
        item.purchasing_url.present?
      end
      score 10, on: ['reagents#create', 'devices#create'] do |item|
        item.shared?
      end
      # %w(icon pdf).each do |attribute|
      #   score 10, on: ['reagents#create', 'devices#create]' do |item|
      #     item.attribute.present?
      #   end
      # end
      score 10, on: ['reagents#create', 'devices#create'] do |item|
        item.icon.present?
      end
      score 10, on: ['reagents#create', 'devices#create'] do |item|
        item.pdf.present?
      end

      score 4, on: ['reagents#clone', 'devices#clone']
      # %w(serial location description product_url purchasing_url).each do |attribute|
      #   score 4, on: ['reagents#clone', 'devices#clone]' do |item|
      #     item.attribute.present?
      #   end
      # end
      score 4, on: 'reagents#clone' do |item|
        item.expiration.present?
      end
      score 4, on: 'reagents#clone' do |item|
        item.lot_number.present?
      end
      score 4, on: 'reagents#clone' do |item|
        item.quantity.present?
      end
      score 4, on: ['reagents#clone', 'devices#clone'] do |item|
        item.serial.present?
      end
      score 4, on: ['reagents#clone', 'devices#clone'] do |item|
        item.location.present?
      end
      score 4, on: ['reagents#clone', 'devices#clone'] do |item|
        item.description.present?
      end
      score 4, on: ['reagents#clone', 'devices#clone'] do |item|
        item.price > 0
      end
      score 4, on: ['reagents#clone', 'devices#clone'] do |item|
        item.product_url.present?
      end
      score 4, on: ['reagents#clone', 'devices#clone'] do |item|
        item.purchasing_url.present?
      end
      score 15, on: ['reagents#clone', 'devices#clone'] do |item|
        item.shared?
      end
      # %w(pdf icon).each do |attribute|
      #   score 15, on: ['reagents#clone', 'devices#clone]' do |item|
      #     item.attribute.present?
      #   end
      # end
      score 15, on: ['reagents#clone', 'devices#clone'] do |item|
        item.icon.present?
      end
      score 15, on: ['reagents#clone', 'devices#clone'] do |item|
        item.pdf.present?
      end

      score 5, on: ['reagents#destroy', 'devices#destroy', 'bookings#destroy']
    end
  end
end