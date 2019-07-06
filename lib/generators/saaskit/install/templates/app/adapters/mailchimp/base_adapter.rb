module Mailchimp
  class BaseAdapter
    MAILCHIMP_API_KEY = Rails.application.credentials[:mailchimp][:api_key]
    MAILCHIMP_AUDIENCE_ID = Rails.application.credentials[:mailchimp][:audience_id]

    def initialize
      @client = ::Gibbon::Request.new(api_key: MAILCHIMP_API_KEY)
      @client.timeout = 30
      @client.open_timeout = 30
      @client.symbolize_keys = true
      @client.debug = false
    end

    def pending_subscribe(options)
      options = build_options(options)

      options = {
        list_id: MAILCHIMP_AUDIENCE_ID,
        status: "pending",
      }.merge!(options)

      body = {
        'email_address': options[:email],
        'status': options[:status],
      }

      body[:merge_fields] = {} if options.key?(:first_name) || options.key?(:last_name)
      body[:merge_fields][:FNAME] = options[:first_name] if options.key?(:first_name)
      body[:merge_fields][:LNAME] = options[:last_name] if options.key?(:last_name)

      email_hash = Digest::MD5.hexdigest(options[:email].downcase)

      begin
        @client.lists(options[:list_id]).members(email_hash).upsert(body: body)
      rescue Gibbon::MailChimpError => exception
        OpenStruct.new(success?: false, error: "Subscribe failed")
      else
        OpenStruct.new(success?: true, error: nil)
      end
    end

    def build_options(options)
      if options.key?(:user_id)
        user = User.find(options[:user_id])
        {email: user.email, first_name: user.first_name, last_name: user.last_name}
      elsif options.key?(:email)
        {email: options[:email]}
      end
    end
  end
end
