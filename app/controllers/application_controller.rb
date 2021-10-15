class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def get_accept_of_file_field(field)
    field.field_options.each do |option|
      if option.label=="accept"
        return option.label_value
      end
    end
    return ""
  end
  def get_type_of_file_field_option(options)
    options.each do |option|
      if option.label=="accept"
        return option
      end
    end
    options.build
  end
  def get_multiple_file_field_option_answer(field)
    field.field_options.each do |option|
      if option.label=="multiple"
        return option.label_value=="1" ? true : false
      end
    end
    false
  end

  def get_multiple_file_field_option(options)
    options.each do |option|
      if option.label=="multiple"
        return option
      end
    end
    options.build
  end
  def get_min_date_constraint(options)
    options.each do |option|
      if option.label=="Minimum"
        return option
      end
    end
    options.build
  end
  def get_max_date_constraint(options)
    options.each do |option|
      if option.label=="Maximum"
        return option
      end
    end
    options.build
  end
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  def print_flash_messages
    
  end
  def get_date_constraint_from_fields(field, label)
    field.field_options.each do |option|
      if option.label==label
        return option.label_value
      end
    end
    return nil
    # field.field_options.find_by(label: label).try(:label_value)
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

  helper_method :get_model_object, :get_date_constraint_from_fields, :get_model_object_option, :get_min_date_constraint, :get_max_date_constraint, :get_multiple_file_field_option, :get_multiple_file_field_option_answer, :get_type_of_file_field_option, :get_accept_of_file_field

  private
    def user_not_authorized
      redirect_to(request.referrer || root_path)
    end
end
