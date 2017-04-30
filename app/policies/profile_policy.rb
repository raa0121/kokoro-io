class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def archived?
    true
  end

  def show?
    true
  end

  def update?
    @record.available? && @record.publisher == @user
  end
end
