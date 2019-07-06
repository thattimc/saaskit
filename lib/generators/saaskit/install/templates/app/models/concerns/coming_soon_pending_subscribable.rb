module ComingSoonPendingSubscribable
  extend ActiveSupport::Concern

  included do
    attr_writer :suppressed
    validate :pending_subscribe, if: :allow_pending_subscribe?
  end

  private

  NEWSLETTER = "mailchimp"

  def allow_pending_subscribe?
    !suppressed?
  end

  def suppressed?
    @suppressed ||= false
  end

  def pending_subscribe
    response = newsletter_provider_class.new.pending_subscribe(email: email)
    unless response.success?
      errors[:base] << response.error
    end
  end

  def newsletter_provider_class
    "#{NEWSLETTER.capitalize}::BaseAdapter".constantize
  end
end
