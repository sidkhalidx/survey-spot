class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def get_min_date_constraint(options)
    if options.find_by(label: 'Minimum').present?
      options.find_by(label: 'Minimum')
    else
      options.build
    end
  end
  def get_max_date_constraint(options)
    if options.find_by(label: 'Maximum').present?
      options.find_by(label: 'Maximum')
    else
      options.build
    end
  end
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  def print_flash_messages
    
  end
  def get_date_constraint_from_fields(field, label)
    field.field_options.find_by(label: label).try(:label_value)
  end
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

  helper_method :get_model_object, :get_date_constraint_from_fields, :get_model_object_option, :get_min_date_constraint, :get_max_date_constraint#, :toastr_flash

  private
    def user_not_authorized
      redirect_to(request.referrer || root_path)
    end
end
