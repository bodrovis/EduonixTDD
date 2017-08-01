require 'test_helper'

describe User do
  subject { users(:user_1) }
  let(:another_user) { users(:user_2) }

  describe 'validations' do
    it 'is not valid with a duplicating email' do
      subject.email = another_user.email
      refute subject.valid?
    end

    it 'is not valid without an email' do
      subject.email = nil
      refute subject.valid?
    end

    it 'is not valid without a name' do
      subject.name = nil
      refute subject.valid?
    end

    it 'is valid with a name and an email' do
      assert subject.valid?
    end
  end

  describe '#subscriptions' do
    it 'should return a proper collection' do
      assert_includes subject.subscriptions, subscriptions(:one)
    end
  end
end

# class UserTest < ActiveSupport::TestCase
#   def setup
#     @user = users(:john)
#   end
#
#   test 'is not valid without an email' do
#     @user.email = nil
#     refute @user.valid?
#   end
#
#   test 'is not valid without a name' do
#     @user.name = nil
#     refute @user.valid?
#   end
#
#   test 'is valid with a name and an email' do
#     assert @user.valid?
#   end
# end