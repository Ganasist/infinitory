require 'faker'

namespace :db do
  desc "Fill database with Institutes, Labs and users"
  task populate: :environment do
    Rake::Task['db:schema:load'].invoke
    r = Random.new
    
    1.times do |n|
      institute = FactoryGirl.create(:institute, city: Faker::Address.city)

      1.times do |n|   
        gl = User.create!(role:                  'group_leader',
                          email:                 Faker::Internet.email,
                          institute_name:        institute.name,                  
                          password:              'loislane',
                          password_confirmation: 'loislane')
        
        gl.first_name = Faker::Name.first_name
        gl.last_name  = Faker::Name.last_name
        gl.created_at = rand(2000.days).ago
        gl.joined     = gl.created_at
        gl.save
        gl.lab.created_at  = gl.created_at
        gl.lab.save
        
        r.rand(15..25).times do |n|
          role = %w[lab_manager research_associate postdoctoral_researcher doctoral_candidate 
                     master's_student project_student technician other].sample
          user = User.create!(role:                   role,
                              email:                  Faker::Internet.email,
                              lab:                    gl.lab,
                              password:               'loislane',
                              password_confirmation:  'loislane')

          user.first_name = Faker::Name.first_name
          user.last_name  = Faker::Name.last_name
          user.created_at = rand(user.gl.created_at..Time.now)
          user.joined     = user.created_at
          user.approved   = true
          user.save
        end

        r.rand(200..1000).times do |n|
          reagent = FactoryGirl.create(:reagent, lab: gl.lab, updated_at: rand(gl.created_at..Time.now))
          reagent.user_ids = gl.lab.user_ids.sample((gl.lab.size / 1.5))
        end

        r.rand(200..1000).times do |n|
          device = FactoryGirl.create(:device, lab: gl.lab, updated_at: rand(gl.created_at..Time.now))
          device.user_ids = gl.lab.user_ids.sample((gl.lab.size / 1.5))
        end
      end
      
      # r.rand(2..3).times do |n|  
      #   department = Department.create!(name:      Faker::Company.name,
      #                                   institute: institute,
      #                                   room:      "#{Random.new.rand(1..999)}" + "#{[*('A'..'Z')].sample}",
      #                                   address:   Faker::Address.street_address,
      #                                   city:      institute.city,
      #                                   url:       Faker::Internet.url )
        
      #   r.rand(3..4).times do |n|   
      #     gl = User.create!(role:                  'group_leader',
      #                       email:                 Faker::Internet.email,
      #                       institute_name:        institute.name,
      #                       department:            department,                    
      #                       password:              'loislane',
      #                       password_confirmation: 'loislane')
          
      #     gl.first_name = Faker::Name.first_name
      #     gl.last_name  = Faker::Name.last_name
      #     gl.created_at = rand(1000.days).ago
      #     gl.joined     = gl.created_at
      #     gl.save
          
      #     r.rand(6..20).times do |n|
      #       role = %w[lab_manager research_associate postdoctoral_researcher doctoral_candidate 
      #                  master's_student project_student technician other].sample
      #       user = User.create!(role: role,
      #                           email:                  Faker::Internet.email,
      #                           lab:                    gl.lab,
      #                           password:               'loislane',
      #                           password_confirmation:  'loislane')

      #       user.first_name = Faker::Name.first_name
      #       user.last_name  = Faker::Name.last_name
      #       user.created_at = rand(user.gl.created_at..Time.now)
      #       user.joined     = user.created_at
      #       user.approved   = true
      #       user.save
      #     end

      #     r.rand(20..500).times do |n|
      #       reagent = FactoryGirl.create(:reagent, lab: gl.lab, updated_at: rand(gl.created_at..Time.now))
      #       reagent.user_ids = gl.lab.user_ids.sample((gl.lab.size / 3))
      #     end

      #     r.rand(20..500).times do |n|
      #       device = FactoryGirl.create(:device, lab: gl.lab, updated_at: rand(gl.created_at..Time.now))
      #       device.user_ids = gl.lab.user_ids.sample((gl.lab.size / 3))
      #     end
      #   end
      # end
    end
  end
end 