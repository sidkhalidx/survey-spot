class FormsController < ApplicationController
    before_action :get_organization, only: [:index, :new, :create, :show]
    before_action :get_form_after_organization, only: [:edit, :update, :emails, :result, :answers, :destroy, :show]

    def get_form_after_organization
        @form = Form.find(params[:id])
    end
    def get_organization
        @organization = current_user.organization
    end
    def index
        authorize Form
        @forms = Form.search(@organization.id, params[:search]).paginate(page: params[:page], per_page: 3)
    end

    def new
        @form = @organization.forms.build
        authorize @form
    end

    def create
        @form = @organization.forms.build(form_params)
        if @form.save
            flash[:success] = "#{@form.title} Survey created"
            redirect_to forms_path
        else
            render 'new'
        end
    end
    
    def edit
        authorize @form
    end

    def update
        if @form.update(form_params)
            flash[:success] = "#{@form.title} Survey updated successfully"
            redirect_to form_path(@form)
        else
            render "edit"
        end
    end
    def show
    end
    def emails
        authorize Form
        @to_emails = EndUser.where(form_id: params[:id])
        @to_emails = Form.search_emails(@form, params[:search])
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
    def result
        @form_submissions = FormSubmission.where(form_id: params[:form_id])
    end
    def answers
        @field = Field.find(params[:field_id])
        @answers = @field.answers
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
        params.require(:form).permit(:title, :form_type, :search, fields_attributes: [:id, :field_type, :title, :is_required, :_destroy, field_options_attributes: [:id, :label, :_destroy, :label_value]])
    end
    def destroy
        authorize @form
        name = @form.title
        @form.destroy
        flash[:success]="Survey (#{name}) deleted successfully"
        redirect_to request.referrer
    end
end
