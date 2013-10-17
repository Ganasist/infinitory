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

  it 'should have a Privacy Policy link' do
    get '/'
    response.body.should have_link('Privacy Policy', page_path('privacy'))
  end

  it 'should have an sign-in page at /login' do
    get '/login'
    response.body.should have_field('Email')
    response.body.should have_field('Password')
    response.body.should have_link('Sign up')
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
    response.body.should have_link('Sign in')
    response.body.should have_link('Forgot your password?')
    response.body.should have_link("Didn't receive confirmation instructions?")    
  end

  it 'should have the right links in the layout' do
    visit root_path
    expect(page).to have_content 'Sign-up'
    click_link 'Privacy Policy'
    expect(page).to have_content 'Privacy Policy'
    click_link('About Infinitory', page_path('about'))
    expect(page).to have_content 'About Infinitory'    
  end

  it 'should have an About page at /about' do
    get '/about'
    response.body.should have_content('About Infinitory')
  end

  it 'should have a Privacy Policy at /privacy' do
    get '/privacy'
    response.body.should have_content('Privacy Policy')
  end
end
