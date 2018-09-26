require 'rails_helper'

RSpec.describe SaltSprayTest do
  subject(:test) { 
    described_class.new(so_num: "123", load_num: "123") }

  describe "Validations" do
    context "with valid attributes" do
      it { 
        expect(test).to be_valid }
    end 

    context "without shop order #" do
      it { 
        test.so_num = nil
        expect(test).to_not be_valid }
    end 

    context "without load #" do
      it { 
        test.load_num = nil
        expect(test).to_not be_valid }
    end
  end

  describe "Associations" do
    it "has one on_user" do
      assoc = described_class.reflect_on_association(:on_user)
      expect(assoc.macro).to eq :has_one
    end

    it "has one off_user" do
      assoc = described_class.reflect_on_association(:off_user)
      expect(assoc.macro).to eq :has_one
    end
    it "has one red_user" do
      assoc = described_class.reflect_on_association(:red_user)
      expect(assoc.macro).to eq :has_one
    end
    it "has one white_user" do
      assoc = described_class.reflect_on_association(:white_user)
      expect(assoc.macro).to eq :has_one
    end
  end
end