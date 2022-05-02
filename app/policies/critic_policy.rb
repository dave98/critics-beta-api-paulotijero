class CriticPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.where(approved: true) unless user # current_user // nil

      if user.admin?
        scope.all
      else
        scope.where(user: user).or(scope.where(approved: true)) # Critic.where(user: user).or(Critic.where(approved: true)) -> No es un or de lógica sino a nivel de sql.
      end
    end
  end

  def permitted_attributes
    if user.admin?
      %i[title body approved]
    else
      %i[title body]
    end
  end

  def new?
    create?
  end

  def create?
    user
  end

  def update?
    user.admin? || record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || record.user == user # Equivalente a: current_user.admin? ||  @Critic.user = ...
  end
end
