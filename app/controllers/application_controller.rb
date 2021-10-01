class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def get_model_object(field, form_submission_id)
    if field.answers.try(:any?) && field.answers.find_by(form_submission: form_submission_id).present?
      return field.answers.find_by(form_submission: form_submission_id)
    else
      return field.answers.build
    end
  end
  def get_model_object_option(field, form_submission_id, option_label)
    if field.answers.try(:any?) && field.answers.find_by(form_submission: form_submission_id).present? && field.answers.find_by(form_submission: @form_submission, answer: option_label).present?
      return field.answers.find_by(form_submission: form_submission_id, answer: option_label)
    else
      return field.answers.build
    end
  end

  helper_method :get_model_object, :get_model_object_option

  private
    def user_not_authorized
      redirect_to(request.referrer || root_path)
    end
end
