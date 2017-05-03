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
    !@record.archived?
  end

  def update?
    !@record.archived? && @record.publisher == @user
  end
end
