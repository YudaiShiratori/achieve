class ContactsController < ApplicationController
  before_action :set_contact, only:[:show, :edit, :update, :destroy]
  
  def index
    @contacts = Contacts.all
  end

  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
      
    respond_to do |format|
      if @contact.save
        ContactMailer.contact_mail(@contact).deliver
        format.html{ redirect_to @contact, notice:'送信されました'}
        format.json{ render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end
  
  private
  
  def set_contact
    @contact = Contact.find(params[:id])
  end
  
  def contact_params
    params.require(:contact).permit(:name,:email,:content)
  end

end