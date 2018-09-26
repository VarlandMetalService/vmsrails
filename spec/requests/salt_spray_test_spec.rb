require 'rails_helper'
require 'spec_helper'

RSpec.describe "index" do
  context "when off-site" do
    it{
      get salt_spray_tests_path
      expect(response).to redirect_to login_url }
    it {
      assert_select "form.login" do
        assert_select "input[name=?]"
      end
    }
  end
    context "with invalid attributes"
end