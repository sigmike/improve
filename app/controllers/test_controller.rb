class TestController < ApplicationController
  def save
    date = Time.zone.local(
      params[:date][:year].to_i,
      params[:date][:month].to_i, 
      params[:date][:day].to_i,
      params[:date][:hour].to_i,
      params[:date][:minute].to_i
    )
    params[:result].each do |question_id, value|
      if params[:save][question_id] == "1"
        Result.create! :question_id => question_id, :value => value, :date => date
      end
    end
  end
end
