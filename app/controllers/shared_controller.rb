class SharedController < ApplicationController
  def show
    @patient = current_patient
    @reports = @patient.reports.order(created_at: :desc).limit(5)
    @answers = @reports.map(&:answers).flatten
  end
end
