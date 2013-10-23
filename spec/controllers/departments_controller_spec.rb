require 'spec_helper'

describe DepartmentsController do

  # This should return the minimal set of attributes required to create a valid
  # Department. As you add validations to Department, be sure to
  # adjust the attributes here as well.
  # let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DepartmentsController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  # describe "GET index" do
  #   it "assigns all departments as @departments" do
  #     department = Department.create! valid_attributes
  #     get :index, {}, valid_session
  #     assigns(:departments).should eq([department])
  #   end
  # end

  # describe "GET show" do
  #   it "assigns the requested department as @department" do
  #     department = Department.create! valid_attributes
  #     get :show, {:id => department.to_param}, valid_session
  #     assigns(:department).should eq(department)
  #   end
  # end

  # describe "GET new" do
  #   it "assigns a new department as @department" do
  #     get :new, {}, valid_session
  #     assigns(:department).should be_a_new(Department)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested department as @department" do
  #     department = Department.create! valid_attributes
  #     get :edit, {:id => department.to_param}, valid_session
  #     assigns(:department).should eq(department)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Department" do
  #       expect {
  #         post :create, {:department => valid_attributes}, valid_session
  #       }.to change(Department, :count).by(1)
  #     end

  #     it "assigns a newly created department as @department" do
  #       post :create, {:department => valid_attributes}, valid_session
  #       assigns(:department).should be_a(Department)
  #       assigns(:department).should be_persisted
  #     end

  #     it "redirects to the created department" do
  #       post :create, {:department => valid_attributes}, valid_session
  #       response.should redirect_to(Department.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved department as @department" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Department.any_instance.stub(:save).and_return(false)
  #       post :create, {:department => { "name" => "invalid value" }}, valid_session
  #       assigns(:department).should be_a_new(Department)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Department.any_instance.stub(:save).and_return(false)
  #       post :create, {:department => { "name" => "invalid value" }}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested department" do
  #       department = Department.create! valid_attributes
  #       # Assuming there are no other departments in the database, this
  #       # specifies that the Department created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Department.any_instance.should_receive(:update).with({ "name" => "MyString" })
  #       put :update, {:id => department.to_param, :department => { "name" => "MyString" }}, valid_session
  #     end

  #     it "assigns the requested department as @department" do
  #       department = Department.create! valid_attributes
  #       put :update, {:id => department.to_param, :department => valid_attributes}, valid_session
  #       assigns(:department).should eq(department)
  #     end

  #     it "redirects to the department" do
  #       department = Department.create! valid_attributes
  #       put :update, {:id => department.to_param, :department => valid_attributes}, valid_session
  #       response.should redirect_to(department)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the department as @department" do
  #       department = Department.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Department.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => department.to_param, :department => { "name" => "invalid value" }}, valid_session
  #       assigns(:department).should eq(department)
  #     end

  #     it "re-renders the 'edit' template" do
  #       department = Department.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Department.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => department.to_param, :department => { "name" => "invalid value" }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested department" do
  #     department = Department.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => department.to_param}, valid_session
  #     }.to change(Department, :count).by(-1)
  #   end

  #   it "redirects to the departments list" do
  #     department = Department.create! valid_attributes
  #     delete :destroy, {:id => department.to_param}, valid_session
  #     response.should redirect_to(departments_url)
  #   end
  # end

end
