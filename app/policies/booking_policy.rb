class BookingPolicy < ApplicationPolicy
	attr_reader :user, :booking

	def initialize(user, booking)
		@user = user
		@booking = booking
	end

	def show?
		user.id == booking.user_id
	end

	def edit?
		show? and booking.device.bookable?
	end

	def update?
		show?
	end

	def destroy?
		show?
	end
end