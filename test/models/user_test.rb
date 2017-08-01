require 'test_helper'

describe User do
  subject { users(:john) }

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