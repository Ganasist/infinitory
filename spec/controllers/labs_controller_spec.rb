require 'spec_helper'

# describe LabsController do

#   # This should return the minimal set of attributes required to create a valid
#   # Lab. As you add validations to Lab, be sure to
#   # adjust the attributes here as well.
#   let(:valid_attributes) { { "department_id" => "1" } }

#   # This should return the minimal set of values that should be in the session
#   # in order to pass any filters (e.g. authentication) defined in
#   # LabsController. Be sure to keep this updated too.
#   let(:valid_session) { {} }

#   describe "GET index" do
#     it "assigns all labs as @labs" do
#       lab = Lab.create! valid_attributes
#       get :index, {}, valid_session
#       assigns(:labs).should eq([lab])
#     end
#   end

#   describe "GET show" do
#     it "assigns the requested lab as @lab" do
#       lab = Lab.create! valid_attributes
#       get :show, {:id => lab.to_param}, valid_session
#       assigns(:lab).should eq(lab)
#     end
#   end

#   describe "GET new" do
#     it "assigns a new lab as @lab" do
#       get :new, {}, valid_session
#       assigns(:lab).should be_a_new(Lab)
#     end
#   end

#   describe "GET edit" do
#     it "assigns the requested lab as @lab" do
#       lab = Lab.create! valid_attributes
#       get :edit, {:id => lab.to_param}, valid_session
#       assigns(:lab).should eq(lab)
#     end
#   end

#   describe "POST create" do
#     describe "with valid params" do
#       it "creates a new Lab" do
#         expect {
#           post :create, {:lab => valid_attributes}, valid_session
#         }.to change(Lab, :count).by(1)
#       end

#       it "assigns a newly created lab as @lab" do
#         post :create, {:lab => valid_attributes}, valid_session
#         assigns(:lab).should be_a(Lab)
#         assigns(:lab).should be_persisted
#       end

#       it "redirects to the created lab" do
#         post :create, {:lab => valid_attributes}, valid_session
#         response.should redirect_to(Lab.last)
#       end
#     end

#     describe "with invalid params" do
#       it "assigns a newly created but unsaved lab as @lab" do
#         # Trigger the behavior that occurs when invalid params are submitted
#         Lab.any_instance.stub(:save).and_return(false)
#         post :create, {:lab => { "department_id" => "invalid value" }}, valid_session
#         assigns(:lab).should be_a_new(Lab)
#       end

#       it "re-renders the 'new' template" do
#         # Trigger the behavior that occurs when invalid params are submitted
#         Lab.any_instance.stub(:save).and_return(false)
#         post :create, {:lab => { "department_id" => "invalid value" }}, valid_session
#         response.should render_template("new")
#       end
#     end
#   end

#   describe "PUT update" do
#     describe "with valid params" do
#       it "updates the requested lab" do
#         lab = Lab.create! valid_attributes
#         # Assuming there are no other labs in the database, this
#         # specifies that the Lab created on the previous line
#         # receives the :update_attributes message with whatever params are
#         # submitted in the request.
#         Lab.any_instance.should_receive(:update).with({ "department_id" => "1" })
#         put :update, {:id => lab.to_param, :lab => { "department_id" => "1" }}, valid_session
#       end

#       it "assigns the requested lab as @lab" do
#         lab = Lab.create! valid_attributes
#         put :update, {:id => lab.to_param, :lab => valid_attributes}, valid_session
#         assigns(:lab).should eq(lab)
#       end

#       it "redirects to the lab" do
#         lab = Lab.create! valid_attributes
#         put :update, {:id => lab.to_param, :lab => valid_attributes}, valid_session
#         response.should redirect_to(lab)
#       end
#     end

#     describe "with invalid params" do
#       it "assigns the lab as @lab" do
#         lab = Lab.create! valid_attributes
#         # Trigger the behavior that occurs when invalid params are submitted
#         Lab.any_instance.stub(:save).and_return(false)
#         put :update, {:id => lab.to_param, :lab => { "department_id" => "invalid value" }}, valid_session
#         assigns(:lab).should eq(lab)
#       end

#       it "re-renders the 'edit' template" do
#         lab = Lab.create! valid_attributes
#         # Trigger the behavior that occurs when invalid params are submitted
#         Lab.any_instance.stub(:save).and_return(false)
#         put :update, {:id => lab.to_param, :lab => { "department_id" => "invalid value" }}, valid_session
#         response.should render_template("edit")
#       end
#     end
#   end

#   describe "DELETE destroy" do
#     it "destroys the requested lab" do
#       lab = Lab.create! valid_attributes
#       expect {
#         delete :destroy, {:id => lab.to_param}, valid_session
#       }.to change(Lab, :count).by(-1)
#     end

#     it "redirects to the labs list" do
#       lab = Lab.create! valid_attributes
#       delete :destroy, {:id => lab.to_param}, valid_session
#       response.should redirect_to(labs_url)
#     end
#   end

# end
