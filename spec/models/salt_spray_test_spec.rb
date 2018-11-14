require 'rails_helper'

RSpec.describe SaltSprayTest do
  let(:user) { User.new()}
  subject(:test) { described_class.new(so_num: "123", load_num: "123") }

  describe "Validations" do
    context "with valid attributes" do
      it { expect(test).to be_valid }
    end 
  end

  describe "Associations" do
    it { should have_many(:salt_spray_test_checks) }
    it { should have_many(:comments) }
    it { should belong_to(:user) }

  end
end