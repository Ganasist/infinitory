require 'faker'

namespace :db do
  desc "Fill database with Institutes, Labs and users"
  task populate: :environment do
    Rake::Task['db:schema:load'].invoke

    5.times do |n|
      institute = Institute.create!(name:     Faker::Company.name,
                                    address:  Faker::Address.street_address,
                                    city:     Faker::Address.city,
                                    url:      Faker::Internet.url)
      
      Random.new.rand(2..5).times do |n|  
        department      = Department.create!(name:      Faker::Company.name,
                                             institute: institute,
                                             room:      "#{Random.new.rand(1..999)}" + "#{[*('A'..'Z')].sample}",
                                             address:   Faker::Address.street_address,
                                             city:      institute.city,
                                             url:       Faker::Internet.url )
        
        Random.new.rand(3..8).times do |n|   
          gl = User.create!(role: "group_leader",
                            email:                 Faker::Internet.email,
                            first_name:            Faker::Name.first_name,
                            last_name:             Faker::Name.last_name, 
                            institute_name:        institute.name,
                            department:            department,                          
                            password:              'loislane',
                            password_confirmation: 'loislane')
          
          Random.new.rand(5..12).times do |n|
            role         = %w[lab_manager research_associate postdoctoral_researcher doctoral_candidate 
                              master's_student project_student technician other].sample
            User.create!(role: role,
                         email:                  Faker::Internet.email,
                         lab:                    gl.lab,
                         password:               "loislane",
                         password_confirmation:  "loislane")
          end
        end
      end
    end


  end
end 