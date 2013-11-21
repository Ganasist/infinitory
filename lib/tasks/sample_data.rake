require 'faker'

namespace :db do
  desc "Fill database with Institutes, Labs and users"
  task populate: :environment do
    Rake::Task['db:schema:load'].invoke
    r = Random.new
    
    4.times do |n|
      institute = create!(:institute, city: Faker::Address.city)

      r.rand(2..4).times do |n|   
        gl = User.create!(role: "group_leader",
                          email:                 Faker::Internet.email,
                          institute_name:        institute.name,                  
                          password:              'loislane',
                          password_confirmation: 'loislane')
        
        gl.first_name = Faker::Name.first_name
        gl.last_name  = Faker::Name.last_name
        gl.created_at = rand(1000.days).ago
        gl.joined     = gl.created_at
        gl.save
        
        r.rand(5..12).times do |n|
          role = %w[lab_manager research_associate postdoctoral_researcher doctoral_candidate 
                     master's_student project_student technician other].sample
          user = User.create!(role: role,
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

        r.rand(5..12).times do |n|
          role = %w[lab_manager research_associate postdoctoral_researcher doctoral_candidate 
                     master's_student project_student technician other].sample
          user = User.create!(role: role,
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
      end
      
      r.rand(2..10).times do |n|  
        department = Department.create!(name:      Faker::Company.name,
                                        institute: institute,
                                        room:      "#{Random.new.rand(1..999)}" + "#{[*('A'..'Z')].sample}",
                                        address:   Faker::Address.street_address,
                                        city:      institute.city,
                                        url:       Faker::Internet.url )
        
        r.rand(3..15).times do |n|   
          gl = User.create!(role: "group_leader",
                            email:                 Faker::Internet.email,
                            institute_name:        institute.name,
                            department:            department,                    
                            password:              'loislane',
                            password_confirmation: 'loislane')
          
          gl.first_name = Faker::Name.first_name
          gl.last_name  = Faker::Name.last_name
          gl.created_at = rand(1000.days).ago
          gl.joined     = gl.created_at
          gl.save
          
          r.rand(5..20).times do |n|
            role = %w[lab_manager research_associate postdoctoral_researcher doctoral_candidate 
                       master's_student project_student technician other].sample
            user = User.create!(role: role,
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
        end
      end
    end
  end
end 