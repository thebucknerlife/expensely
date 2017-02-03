class PagesController < ApplicationController

  def add_to_slack
    @auth_url = AddToSlack.auth_url
  end

  def homepage

  end

end
