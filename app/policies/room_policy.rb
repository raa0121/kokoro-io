class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    true
  end

  def update?
    @record.maintainable?(@user)
  end

  def join?
    @record.joinable?(@user)
  end

  def leave?
    @record.leaveable?(@user)
  end

  def invite?
    @record.invitable?(@user)
  end

end
