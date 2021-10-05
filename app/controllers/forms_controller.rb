class FormsController < ApplicationController

    def index
        authorize Form
        @forms = current_user.organization.forms.all
    end

    def new
        @form = current_user.forms.build
        authorize @form
    end

    def create
        @form = current_user.forms.build(form_params)
        @form.organization = current_user.organization
        @form.save
    end
    
    def edit
        @form = Form.find(params[:id])
        authorize @form
    end

    def update
        @form = Form.find(params[:id])
        @form.update(form_params)
    end

    def emails
        authorize Form
        @form = Form.find(params[:id])
        @to_emails = EndUser.where(form_id: params[:id])
    end
    def post_send_emails
        emails = params.require(:end_user).permit(:email)
        emails = emails[:email]
        emails = emails.split(',')
        emails.each do |email_f|
            if EndUser.create(email: email_f, form_id: params[:id])
            end
            send_email(email_f, params[:id])
        end
    end
    def resend_email()
        email = params.require(:email)
        form_id = params.require(:form_id)
        send_email(email, form_id)
    end
    def send_email(email, form_id)
        UserMailer.with(email: email.strip, form_id: form_id).send_email_form.deliver_later
    end
    def form_params
        params.require(:form).permit(:title, :form_type, fields_attributes: [:id, :field_type, :title, :is_required, field_options_attributes: [:id, :label]])
    end
    def destroy
        @form = Form.find(params[:id])
        authorize @form
        @form.destroy
    end
end
