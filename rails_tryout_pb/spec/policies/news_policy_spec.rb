require 'rails_helper'

describe NewsPolicy do
  subject { NewsPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:teacher) { FactoryGirl.build_stubbed :user, :teacher }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it "denies access if student" do
      expect(NewsPolicy).not_to permit(current_user)
    end
    it "allows access for an admin or teacher" do
      expect(NewsPolicy).to permit(admin)
      expect(NewsPolicy).to permit(teacher)
    end
  end

  permissions :show? do
    it "allows any user to access show" do
      expect(subject).to permit(current_user)
      expect(subject).to permit(admin)
      expect(subject).to permit(teacher)
    end
  end

end