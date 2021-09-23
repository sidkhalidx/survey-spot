class FormSubmissionsController < ApplicationController
  def new
    @form = Form.find(params[:form_id])
    @form_submission = @form.form_submissions.build
  end

  def create
    byebug
  end
end