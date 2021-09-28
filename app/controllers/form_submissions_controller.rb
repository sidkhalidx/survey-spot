class FormSubmissionsController < ApplicationController
  def new
    @form = Form.find(params[:form_id])
    @form_submission = @form.form_submissions.build
  end

  def create
    byebug
    @form = Form.find(params[:form_id])
    @form_submission = @form.form_submissions.build(form_submission_params)
    @form_submission.save
  end

  def edit
    @form = Form.find(params[:form_id])
    @form_submission = @form.form_submissions.find(params[:id])
  end
  def update
    byebug
    @form_submission = FormSubmission.find(params[:id])
    p = form_submission_params
    @form_submission.update(form_submission_params)
    # byebug
  end
  def form_submission_params
    params.require(:form_submission).permit(:id, answers_attributes: [:id, :field_id, :answer, :images])
  end
end