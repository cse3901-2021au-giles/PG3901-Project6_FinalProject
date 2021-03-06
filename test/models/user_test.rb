# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new name: 'name', email: 'name.1@osu.edu', password: 'foobar', password_confirmation: 'foobar'
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '       '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '       '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.name = "#{'a' * 244}@example.com"
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[name.555@osu.edu NaMe.1@osu.edu NAME.99@osu.edu name.111154546876846157687646@osu.edu
                         name.1@OSU.edu name.1@oSu.Edu]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[name.555+osu.edu name,555@osu.edu name.555@osu,edu name.abc123@osu.edu name123.5@OSU.edu
                           name.555@google.com buckeye@hotmail.com name.555@uso.edu name.555@ou.edu name.555@osu.e]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'bad email' do
    user = User.new(name: 'Dan', email: 'Dan@example.com', password: '123456')
    assert !user.valid?
  end
  test 'valid user' do
    user = User.new(name: 'John', email: 'dan.1@osu.edu', password: '123456')
    assert user.valid?
  end
  test 'short pass' do
    user = User.new(name: 'John', email: 'john@example.com', password: '12345')
    assert !user.valid?
  end
  # check if things are being assigned and can be accessed.
  test 'check name' do
    user = User.new(name: 'Dan', email: 'dan.1@osu.edu', password: '123456')
    assert_equal('Dan', user.name)
  end
  test 'check name wrong' do
    user = User.new(name: 'Dan', email: 'dan.1@osu.edu', password: '123456')
    refute_equal('Danny', user.name)
  end
  test 'check pass' do
    user = User.new(name: 'Dan', email: 'dan.1@osu.edu', password: '123456')
    assert_equal('123456', user.password)
  end
  test 'check pass wrong' do
    user = User.new(name: 'Dan', email: 'dan.1@osu.edu', password: '123456')
    refute_equal('123', user.password)
  end
  test 'check email' do
    user = User.new(name: 'Dan', email: 'dan.1@osu.edu', password: '123456')
    assert_equal('dan.1@osu.edu', user.email)
  end
  test 'check email wrong' do
    user = User.new(name: 'Dan', email: 'dan.1@osu.edu', password: '123456')
    refute_equal('dan.2@osu.edu', user.email)
  end
end
