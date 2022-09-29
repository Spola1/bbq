require 'rails_helper'

RSpec.describe SubscriptionPolicy do
  let(:user_is_an_owner) { User.new }
  let(:user_is_not_an_owner) { User.new }
  let(:user_is_admin) { User.new admin: true }
  let(:user_is_redactor) { User.new redactor: true }
  let(:subscription) { user_is_an_owner.subscriptions.build }

  subject { SubscriptionPolicy }

  context 'when user authorized' do
    permissions :destroy? do
      context 'and is the owner of subscription' do
        it 'gets permission' do
          is_expected.to permit(user_is_an_owner, subscription)
        end
      end

      context 'and is the admin' do
        it 'gets permission' do
          is_expected.to permit(user_is_admin, subscription)
        end
      end

      context 'and is not the owner of subscription' do
        it 'does not get permission' do
          is_expected.not_to permit(user_is_not_an_owner, subscription)
        end
      end

      context 'and is the redactor' do
        it 'gets pesmission' do
          is_expected.to permit(user_is_redactor, subscription)
        end
      end

      context 'and is the redactor (try destroy admin.subscription)' do
        let(:subscription) { user_is_admin.subscriptions.build }
        it 'does not gets pesmission' do
          is_expected.not_to permit(user_is_redactor, subscription)
        end
      end
    end
  end

  context 'when user not authotized' do
    permissions :destroy? do
      it 'does not gets permission' do
        is_expected.not_to permit(nil, subscription)
      end
    end
  end
end
