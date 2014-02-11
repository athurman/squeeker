class SqueeksController < ApplicationController
  before_filter :load_squeeks

  def index
    @squeek = Squeek.new
  end

  def create
    squeek_params = params.require(:squeek).permit(:body)
    # ^^^Rails 4 way of protecting params, must do this
    # in order to access the information passed through.
    @squeek = Squeek.create(squeek_params) # from form submission in the views, comes through as a hash.
    if @squeek.save
      flash[:notice] = "Your squeek has been posted"
      redirect_to squeeks_path
    else
      flash[:alert] = "Your squeek couldn't be posted. #{@squeek.errors.full_messages.join(" ")}"
      render :index
    end
  end

  private

  def load_squeeks
    @squeeks = Squeek.all
  end
end