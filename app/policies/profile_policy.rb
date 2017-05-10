class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show_friendly?
    true
  end

  def show?
    true
  end

  def update?
    !@record.archived? && @record.publisher == @user
  end
end
