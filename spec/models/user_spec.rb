require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(name: 'test name', email: 'test@test.ru', password: 'asdfasdf', admin: true)
  end

  it 'instance is class User' do
    expect(@user).to be_an_instance_of User
  end

  describe 'creation' do
    it 'should have 3 items created after being created' do
      expect(User.all.count).to eq(1)
    end

    it 'should create valid User with correct name, email, password' do
      expect(@user).to be_valid
      expect(@user.name).to eq('test name')
      expect(@user.email).to eq('test@test.ru')
      expect(@user.password).to eq('asdfasdf')
      expect(@user.admin).to be true
    end
  end

  describe 'validations' do
    it 'should not let a user be created without an email address' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'should not let a user be created without an name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'should not let a user be created with invalid password' do
      @user.password = '12345'
      expect(@user).to_not be_valid
    end
  end
end
