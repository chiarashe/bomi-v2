class ReportPolicy < ApplicationPolicy
  def new?
    user == record.patient
  end

  def create?
    user == record.patient
  end
end
