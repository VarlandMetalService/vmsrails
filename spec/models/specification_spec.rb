require 'rails_helper'

RSpec.describe Specification do
  # Validations
  describe "Validations" do
    it "has a valid factory" do
      expect(build_stubbed(:specification)).to be_valid
    end
    it "is invalid without organization" do
      expect(build_stubbed(:specification, organization: nil)).to_not be_valid
    end
    it "is invalid without name" do
      expect(build_stubbed(:specification, name: nil)).to_not be_valid
    end
    it "is invalid without description" do
      expect(build_stubbed(:specification, description: nil)).to_not be_valid
    end
  end

  # Associations
  describe "Associations" do
    it { assoc = described_class.reflect_on_association(:classifications)
      expect(assoc.macro).to eq :has_many }
  end

  # Scoping Class Methods
  describe Specification, ".without_archived"
  describe Specification, ".archived"
  describe Specification, ".with_organization"
  describe Specification, ".with_name"
  describe Specification, ".with_classification"
  describe Specification, ".with_prcoess_code"
  describe Specification, ".with_color"
  describe Specification, ".with_search_term"
  describe Specification, ".with_inert_bake"
  describe Specification, ".with_ss_white_spec"
  describe Specification, ".with_ss_red_spec"
  describe Specification, ".with_min_alloy_percentage"
  describe Specification, ".with_max_alloy_percentage"
  describe Specification, ".with_min_thickness"
  describe Specification, ".with_max_thickness"
  describe Specification, ".with_bake_temperature"
  describe Specification, ".with_bake_time"
  describe Specification, ".with_bake_within_limit"
  describe Specification, ".with_numeric_term"
  describe Specification, ".with_numeric"
  describe Specification, ".with_thickness_term"
  describe Specification, ".with_thickness"
  describe Specification, ".with_temperature_term"
  describe Specification, ".with_temperature"
  describe Specification, ".with_temp_variation_term"
  describe Specification, ".with_temp_variation"

  # Non-scoping Class Methods
  describe Specification, ".default_classification"
  describe Specification, ".title"

  # Instance Methods
  describe Specification, "#filter_form_lists"
end