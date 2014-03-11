class ProfileController < ApplicationController
  before_filter :redirect_unless_logged_in

  def index
  end
end
