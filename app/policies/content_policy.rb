class ContentPolicy < ApplicationPolicy
  def index?
    user.is_a?(Doctor)
  end

  def create?
    user.is_a?(Doctor)
  end

  def update?
    user.is_a?(Doctor) && record.doctor == user
  end

  def destroy?
    user.is_a?(Doctor) && record.doctor == user
  end

  def edit?
    update?
  end

  class Scope < Scope
    def resolve
      scope.where(doctor: user)
    end
  end
end
