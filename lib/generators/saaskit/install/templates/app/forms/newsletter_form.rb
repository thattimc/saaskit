class NewsletterForm
  include ActiveModel::Model
  include ActiveModel::Validations
  include ComingSoonPendingSubscribable

  attr_accessor :email

  validates :email, format: {
    with: /\A[^@\s]+@[^@\s]+\z/,
    message: "Email is invalid",
  }

  def save
    return false unless valid?
    true
  end
end
