class RecommendationPolicy < ApplicationPolicy
  def new?
    user.is_a?(Doctor)
  end

  def create?
    user.is_a?(Doctor)
  end

  def update?
    user.is_a?(Doctor) && record.doctor == user
  end

  def edit?
    update?
  end

  def destroy?
    user.is_a?(Doctor) && record.doctor == user
  end
end
