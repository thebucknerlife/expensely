class PagesController < ApplicationController

  def add_to_slack
    @auth_url = AddToSlack.auth_url
  end

  def homepage

  end

  def landing
    @landing_colors = landing_colors
    render layout: 'landing'
  end

  private

  def landing_colors
    [
      { bg: '#86C0D6', btn: '#3D70B7', color: 'white' },
      { bg: '#D5A564', btn: '#C1585A', color: 'black' },
      { bg: '#2F6542', btn: '#E7A82D', color: 'white' },
      { bg: '#DE92B0', btn: '#B05052', color: 'white' },
    ].sample
  end
end
