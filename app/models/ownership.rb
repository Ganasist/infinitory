class Ownership < ActiveRecord::Base
	belongs_to :user, touch: true, counter_cache: :devices_count, counter_cache: :reagents_count 
  belongs_to :reagent, touch: true, counter_cache: :users_count
  belongs_to :device, touch: true, counter_cache: :users_count

  validates_uniqueness_of :user_id, scope: :reagent_id, message: 'You can only link yourself once to that reagent'
  validates_uniqueness_of :user_id, scope: :device_id, message: 'You can only link yourself once to that device'
end