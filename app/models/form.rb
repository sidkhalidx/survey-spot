class Form < ApplicationRecord
    has_many :end_users, dependent: :destroy
    enum form_type: [:public_form, :email_form]
    # belongs_to :user
    belongs_to :organization
    has_many :fields, dependent: :destroy
    accepts_nested_attributes_for :fields, allow_destroy: true
    accepts_nested_attributes_for :end_users
    has_many :form_submissions, dependent: :destroy
    validate :unique_field_names
    validates :title, presence: true
    validate :delete_unnecessary_fields
    def delete_unnecessary_fields
        self.fields.each do |field|
            if field.field_type=="DateField"
                field.field_options.each do |option|
                    if option.label_value.blank?
                        option.mark_for_destruction
                    end
                end
            end
        end
    end
    def unique_field_names
        self.fields.group_by{|f| f.title}.each do |key, value|
            # byebug
            if value.count > 1
                value.each do |field|
                    field.errors.add(:base, message:"*Field names cant be same")
                end
                self.errors.add(:base, message:"*Field names cant be same")
            end
        end
    end
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