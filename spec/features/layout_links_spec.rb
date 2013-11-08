require 'spec_helper'

describe 'LayoutLinks' do

  it 'should have the right title' do
    get '/'
    response.body.should have_title('Infinitory')
  end

  it 'should have a Root link' do
    get '/'
    response.body.should have_link('Infinitory', root_path)
  end

  it 'should have a Register link' do
    get '/'
    response.body.should have_link('Sign-up', new_user_registration_path)
  end

  it 'should have a Sign-in link' do
    get '/'
    response.body.should have_link('SIGN-IN', new_user_session_path)
  end

  it 'should have an About link' do
    get '/'
    response.body.should have_link('About Infinitory', page_path('about'))
  end

  it 'should have an About page at /about' do
    get '/about'
    response.body.should have_content('About Infinitory')
  end

  it 'should have a Privacy Policy link' do
    get '/'
    response.body.should have_link('Privacy Policy', page_path('privacy'))
  end

  it 'should have a Privacy Policy at /privacy' do
    get '/privacy'
    response.body.should have_content('Privacy Policy')
  end

  it 'should have the right links in the layout' do
    visit root_path
    click_link 'Privacy Policy'
    expect(page).to have_content 'Privacy Policy'
    expect(page).to have_content("INFINITORY", root_path)

    click_link('About Infinitory', page_path('about'))
    expect(page).to have_content("INFINITORY", root_path)
    expect(page).to have_content 'About Infinitory'    
  end

  it 'should have an sign-in page at /login' do
    get '/login'
    response.body.should have_field('Email')
    response.body.should have_field('Password')
    response.body.should have_link('Sign up', new_user_registration_path)
    response.body.should have_link('Forgot your password?')
    response.body.should have_unchecked_field('user[remember_me]')
    response.body.should have_link("Didn't receive confirmation instructions?")   
  end

  it 'should have a Register page at /register' do
    get '/register'
    response.body.should have_select('user[role]')
    response.body.should have_select('user[lab_id]')
    response.body.should have_field('Email address')
    response.body.should have_field('Institute name')
    response.body.should have_field('Password')
    response.body.should have_field('Password confirmation')
    response.body.should have_button('Sign up')
    response.body.should have_link('Sign in', new_user_session_path)
    response.body.should have_link('Forgot your password?')
    response.body.should have_link("Didn't receive confirmation instructions?")    
  end

  describe 'when not signed in' do    
    it 'should have a brand link pointing to the Splash page' do      
      visit root_path
      expect(page).to have_content("INFINITORY", root_path)
    end

    it 'should have a sign-in and sign-up link' do
      visit root_path
      expect(page).to have_link('SIGN-IN', new_user_session_path) 
      expect(page).to have_link('Sign-up', new_user_registration_path)  
    end

    it 'should not have a sign out link' do
      visit root_path
      expect(page).to_not have_link("Sign-out", destroy_user_session_path)
    end
  end

  describe 'when signed in' do

    let(:user) { create(:admin) }

    before(:each) do
      visit root_path
      click_link "SIGN-IN"
      fill_in 'Email',    with: user.email
      fill_in 'Password', with: user.password
      click_button('Sign in')
    end

    it 'should redirect to a User profile page' do      
      expect(page).to have_content("#{user.fullname}")
    end

    it 'should have the right title on the profile page' do      
      expect(page).to have_title("Infinitory | People: #{user.fullname}")
    end

    it 'should have a link to edit the current user' do
      expect(page).to have_link("Edit", edit_user_registration_path(user))
    end

    it 'should not have a link to edit users other than the current user' do
      member = create(:user, lab: user.lab, institute: user.institute)
      visit user_path(member)
      expect(page).to_not have_link("Edit")
    end

    it 'should have a brand link pointing to their profile page' do      
      expect(page).to have_link("INFINITORY", user_path(user))
      click_link("INFINITORY")
      expect(page).to have_title("Infinitory | People: #{user.fullname}")
    end

    it 'should have a new root path redirecting to the User profile page' do
      visit root_path
      expect(page).to have_content("#{user.fullname}")
    end

    it 'should have a sign out link' do
      expect(page).to have_link("Sign-out #{user.fullname}", destroy_user_session_path)
    end

    it 'should not have sign-in or sign-up links at the root path' do
      visit root_path
      expect(page).to_not have_link('SIGN-IN', new_user_session_path)
      expect(page).to_not have_link('Sign up', new_user_registration_path)   
    end
  end
end
