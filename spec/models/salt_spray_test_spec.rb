require 'rails_helper'

RSpec.describe SaltSprayTest do
    
  describe "Validations" do
    it "has a valid factory" do
      salt_spray_test = build_stubbed(:salt_spray_test)
      expect(salt_spray_test).to be_valid
    end 
    it "is invalid without a shop order #" do
      salt_spray_test = build_stubbed(:salt_spray_test, so_num: nil)
      expect(salt_spray_test).to_not be_valid
    end
    it "is invalid without a User" do
      salt_spray_test = build_stubbed(:salt_spray_test, user: nil)
      expect(salt_spray_test).to_not be_valid
    end
  end

  describe "Associations" do
  end

  describe "Instance Methods" do
  end

  # Class Methods
  describe SaltSprayTest, '.not_recently' do
    it "returns only tests that haven't had a check in 4 hours" do
      # Setup
      puts User.all
      bob = create(:user)
      checked_test = create(:salt_spray_test, user: bob)
      check = create(:salt_spray_test_check, salt_spray_test_id: checked_test.id, date: DateTime.now, user_id: bob.id)
      non_checked_test = create(:salt_spray_test, user_id: bob.id)

      expect(SaltSprayTest.not_recently).to include(non_checked_test)
      expect(SaltSprayTest.not_recently).to_not include(checked_test)

      # Teardown
      bob.destroy!
      check.destroy!
      non_checked_test.destroy!
      checked_test.destroy!
    end
  end

  
end