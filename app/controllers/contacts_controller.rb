class ContactsController < ApplicationController
  include WashOut::SOAP

  soap_action "test_soap",
              :return => :string
  def test_soap
    render :soap => "Hello, This is SOAP request test"
  end

  soap_action "get_all_contacts",
              :return => :string
  def get_all_contacts
     @contacts = Contact.all
     if @contacts.present?
       render :soap => @contacts.to_yaml
     else
    render :soap => "No items found to display"
  end
  end


  soap_action "search_name",
              :args   => { :name => :string},
              :return => :string
   def search_name
     @contact = Contact.where(["name=?",params[:name]])
     if @contact.present?
       render :soap => @contact.to_yaml
     else
    render :soap => "No Record found with the given name"
  end
 end


end
