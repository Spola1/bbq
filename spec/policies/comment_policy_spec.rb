require 'rails_helper'

RSpec.describe CommentPolicy do
  let(:user_is_an_owner) { User.new }
  let(:user_is_not_an_owner) { User.new }
  let(:user_is_admin) { User.new admin: true }
  let(:user_is_redactor) { User.new redactor: true }
  let(:comment) { user_is_an_owner.comments.build }

  subject { CommentPolicy }

  context 'when user authorized' do
    permissions :destroy? do
      context 'and is the owner of comment' do
        it 'gets permission' do
          is_expected.to permit(user_is_an_owner, comment)
        end
      end

      context 'and is the admin' do
        it 'gets permission' do
          is_expected.to permit(user_is_admin, comment)
        end
      end

      context 'and is not the owner of comment' do
        it 'does not gets permission' do
          is_expected.not_to permit(user_is_not_an_owner, comment)
        end
      end

      context 'and is the redactor' do
        it 'gets pesmission' do
          is_expected.to permit(user_is_redactor, comment)
        end
      end

      context 'and is the redactor (try destroy admin.comment)' do
        let(:comment) { user_is_admin.comments.build }
        it 'does not gets pesmission' do
          is_expected.not_to permit(user_is_redactor, comment)
        end
      end
    end
  end

  context 'when user not authotized' do
    permissions :destroy? do
      it 'does not gets permission' do
        is_expected.not_to permit(nil, comment)
      end
    end
  end
end
