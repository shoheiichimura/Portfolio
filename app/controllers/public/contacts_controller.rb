class Public::ContactsController < ApplicationController
  
  def new
     @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact, current_customer).deliver
      redirect_to customer_path(current_customer.id), notice: 'お問い合わせ内容を送信しました'
    else
      render :new
    end
  end

  def index
     @contacts = Contact.all
  end
  
  private
    
  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:name, :content)
  end
    
end
