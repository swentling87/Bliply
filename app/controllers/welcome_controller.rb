class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def welcome
  end

  def after_sign_up
  end

  def about
  end
end
