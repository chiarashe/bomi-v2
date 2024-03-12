class MedicinePolicy < ApplicationPolicy
  def create?
    user.is_a?(Patient) && record.patient == user
  end

  def destroy?
    user.is_a?(Patient) && record.patient == user
  end
end
