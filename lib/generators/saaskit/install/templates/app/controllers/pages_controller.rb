class PagesController < ApplicationController
  layout "land"

  # GET /
  def home
    @newsletter_form = NewsletterForm.new
  end

  # POST /subscribe
  def subscribe
    @newsletter_form = NewsletterForm.new(newsletter_form_params)

    respond_to do |format|
      if @newsletter_form.save
        format.html { redirect_to root_url, success: "Successfully subscribed" }
        format.js { flash.now[:notice] = "Successfully subscribed" }
      else
        format.html { render :home }
        format.js
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def newsletter_form_params
    params.require(:newsletter_form).permit(:email, :suppressed)
  end
end
