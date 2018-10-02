require 'rails_helper'
include SessionsHelper
include Utilities

RSpec.describe "Create new rejected part" do
  context "when logged_out" do
    let(:user) { FactoryBot.build_stubbed(:user) }

    it 'logs in, opens rejected part form, creates entry' do
      visit root_path
      expect(current_url).to eq(login_url)
      fill_in 'session_username', with: 'richard'
      fill_in 'session_password', with: 'ring7700'
      click_button 'submit'
      expect(current_url).to eq(root_url)

      click_on 'QC'
      click_on 'Rejected Parts'
      expect(current_url).to eq(new_qc_rejected_part_url)

      fill_in 'so_num', with: '123123123'
      find('#qc_rejected_part_user_id').find(:xpath, 'option[2]').select_option
      fill_in 'qc_rejected_part_date', with: Date.today()
      fill_in 'qc_rejected_part_weight', with: 30
      
      find('#qc_rejected_part_defect').find(:xpath, 'option[2]').select_option
      fill_in 'qc_rejected_part_cause', with: "Blah blah blah blah blah"
      
      expect(click_button 'Save Rejected Parts Form').to_change
      expect(current_url).to eq(root_url)

    end

  end
end