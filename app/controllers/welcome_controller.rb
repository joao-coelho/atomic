require 'yaml'

class WelcomeController < ApplicationController
  def index
    @activities = Activity.next_activities
  end

  def news
  end

  def about
  end

  def team
    @team = YAML.load_file('public/team.yml')
  end

  def partners
    @partners = YAML.load_file('public/partners.yml')
  end

  # in future, replace this method by a controller
  def log
  end

  def contact
  end
end
