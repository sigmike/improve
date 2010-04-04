class SettingsController < ApplicationController
  def save
    current_user.update_attribute :time_zone, params[:time_zone]
  end
end
