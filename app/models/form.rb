class Form < ApplicationRecord
    has_many :end_users, dependent: :destroy
    enum form_type: [:public_form, :email_form]
    # belongs_to :user
    belongs_to :organization
    has_many :fields, dependent: :destroy
    accepts_nested_attributes_for :fields, allow_destroy: true
    accepts_nested_attributes_for :end_users
    has_many :form_submissions, dependent: :destroy
    
    def self.search(organization, search)
        if search
            Form.where(organization_id: organization).where("title LIKE ?", "%"+search+"%")
        else
            Form.where(organization_id: organization)
        end
    end
    def self.search_emails(form, search)
        if search
            EndUser.where(form_id: form).where("email LIKE ?", "%"+search+"%")
        else
            EndUser.where(form_id: form)
        end
    end
    
end