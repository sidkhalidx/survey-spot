class FormSubmissionsController < ApplicationController
  before_action :find_form, only: [:index, :create, :edit, :new]
  before_action :email_form, only: [:new, :edit]
  

  
  def index
    @form_submissions = FormSubmission.where(form_id: params[:form_id]).paginate(page: params[:page], per_page: 6)
    @form = Form.find(params[:form_id])
    authorize FormSubmission
  end
  def new
    redirect_to edit_form_form_submission_path(@form, @form_submission[0])+'?email='+@email if @form_submission.any?
    @form_submission = @form.form_submissions.build
  end
  def edit
    render 'something_wrong' unless @form_submission.any?
    @form_submission = @form.form_submissions.find(params[:id])
  end
  def create
    @form_submission = @form.form_submissions.build(form_submission_params)
    if @form_submission.save
      redirect_to submitted_form_form_submissions_path
    else
      render 'new'
    end
  end
  def show
    @form_submission = FormSubmission.find(params[:id])
    authorize FormSubmission
  end
  def submitted
  end


  def something_wrong
  end
  def update
    @form_submission = FormSubmission.find(params[:id])
    p = form_submission_params
    @form_submission.update(form_submission_params)
  end
  def form_submission_params
    params.require(:form_submission).permit(:id, :email, answers_attributes: [:id, :field_id, :answer, images:[] ])
  end
  def find_form
    @form = Form.find(params[:form_id])
  end

  def email_form
    @email = params[:email]
    render 'something_wrong' if @form.form_type=="email_form" && @email.blank?
    @form_submission=FormSubmission.where(form_id: @form.id, email: @email )
  end
end