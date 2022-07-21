require 'rails_helper'

RSpec.describe PhotoPolicy do
  let(:user_is_an_owner) { User.new }
  let(:user_is_not_an_owner) { User.new }
  let(:photo) { user_is_an_owner.photos.build }

  subject { PhotoPolicy }

  context "when user authorized" do
    permissions :destroy? do
      context "and is the owner of photo" do
        it "gets permission" do
          is_expected.to permit(user_is_an_owner, photo)
        end
      end

      context "and is not the owner of photo" do
        it "does not get permission" do
          is_expected.not_to permit(user_is_not_an_owner, photo)
        end
      end
    end
  end

  context "when user not authotized" do
    permissions :destroy? do
      it "does not gets permission" do
        is_expected.not_to permit(nil, photo)
      end
    end
  end
end
