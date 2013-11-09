require 'spec_helper'

describe Lab do
  
  let(:gl) { create(:admin) }
  let(:lab) { gl.lab }

  context 'relationships' do
    expect_it { to belong_to(:institute) }
    expect_it { to belong_to(:department) }
    expect_it { to have_many(:users) }
    expect_it { to have_many(:reagents) }
  end

  context 'validations' do
    expect_it { to validate_presence_of(:institute) }
    expect_it { to validate_presence_of(:email) }
  end

  context 'database columns' do
    expect_it { to have_db_column(:name).of_type(:string) }
    expect_it { to have_db_column(:department_id).of_type(:integer) }
    expect_it { to have_db_column(:institute_id).of_type(:integer) }
    expect_it { to have_db_column(:room).of_type(:string) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:url).of_type(:string) }    
    expect_it { to have_db_column(:icon).of_type(:string) }
    expect_it { to have_db_column(:icon_processing).of_type(:boolean) }
    expect_it { to have_db_column(:users_count).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:email).of_type(:string) }
  end

  context 'database indexes' do
    expect_it { to have_db_index(:email) }
    expect_it { to have_db_index(:slug).unique(true) }
    expect_it { to have_db_index(:department_id) }
    expect_it { to have_db_index(:institute_id) }
  end

  it 'is valid with a GL and institute' do
    expect(lab).to be_valid
  end

  it 'is invalid without an email address' do
    lab.email = nil
    expect(lab).to_not be_valid
  end

  it 'is invalid without an institute' do
    lab.institute = nil
    expect(lab).to_not be_valid
  end

  it { should belong_to(:institute) }
  it { should belong_to(:department) }
  it { should have_many(:users) }
  it { should have_many(:reagents) }
  it { should validate_presence_of(:institute) }
  it { should validate_presence_of(:email) }
  
  it { should have_db_index(:email) }
  it { should have_db_index(:slug).unique(true) }
  it { should have_db_index(:department_id) }
  it { should have_db_index(:institute_id) }  

  it { should respond_to(:lab_name) }
  its 'lab name should be the same as the group leaders name' do
    expect(lab.lab_name).to eql gl.fullname
  end

  it { should respond_to(:lab_email) }
  its 'lab name should be the same as the group leaders name' do
    expect(lab.lab_email).to eql gl.email
  end

  it 'is invalid without a group leader'
  it 'is invalid with more than one group leader'
  it 'is valid with one group leader'

  it { should respond_to(:gl_count) }

  it { should respond_to(:gl) }
  it 'should return the GL when the gl method is used' do
    expect(lab.gl).to eql gl
  end

  it { should respond_to(:institute_name) }
  it 'should return the name of the host institutes' do
    expect(lab.institute_name).to eql gl.institute.name
  end

  it { should respond_to(:city) }
  it 'should return the labs institutes city when city is called' do
    expect(lab.city).to eql gl.institute.city
  end

  it { should respond_to(:location) }
  describe 'it should respond to the location method' do
    it 'should return blank if the lab does not have a room' do
      lab.room = nil
      expect(lab.location).to eql ""
    end

    it 'should return lab and institute location if the lab does not have a department' do
      expect(lab.location).to eql "#{lab.room} #{lab.institute.address}"
    end

    it 'should return the lab and department location if the lab has a department' do
      department = Department.create(institute: gl.institute)
      expect(lab.location).to eql "#{lab.room} #{department.address}"
    end
  end
end