module ActivitiesHelper
  def can_create?
     can? :create, Activity
  end
end
