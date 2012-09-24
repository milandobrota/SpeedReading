require 'spec_helper'

describe User do

  let(:user) { User.create!(:email => 'user@test.com', :password => 'foobar') }
  let(:member) { User.create!(:email => 'member@test.com', :password => 'foobar', :role => 0) }
  let(:admin) { User.create!(:email => 'admin@test.com', :password => 'foobar', :role => 1) }

  it 'should default to being a member' do
    user.member?.should be_true
  end

  it 'should know its role if member' do
    member.role_name.should == 'member'
  end

  it 'should know its role if admin' do
    admin.role_name.should == 'admin'
  end

  it 'should return true for member?' do
    member.member?.should be_true
  end

  it 'should return false for member?' do
    admin.member?.should be_false
  end

  it 'should return true for admin?' do
    admin.admin?.should be_true
  end

  it 'should return false for admin?' do
    admin.member?.should be_false
  end


end
