class EndUser < ApplicationRecord
  belongs_to :form

  after_commit :send_mail
  validates :email, uniqueness: { scope: :form_id }
  private
    def send_mail

    end
end
