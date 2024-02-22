class ReportPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    user.present?
  end
end
