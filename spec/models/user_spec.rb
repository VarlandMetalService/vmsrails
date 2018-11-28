require 'rails_helper'

RSpec.describe User do

   # Validations
   describe "Validations" do

      it "has a valid factory" do
         expect(build(:user)).to be_valid
      end

      # Employee Number
      it "is invalid without employee number" do
         expect(build(:user, employee_number: nil)).to_not be_valid
      end
      it "is invalid when employee number isn't unique" do
         user = create(:user, employee_number: 123)
         expect(build(:user, employee_number: 123)).to_not be_valid
         user.destroy!
      end

      # Username
      it "is invalid without a username" do
         expect(build(:user, :username => nil)).to_not be_valid
      end
      it "is invalid when username isn't unique" do
         user = create(:user, username: "abc")
         expect(build(:user, username: "abc")).to_not be_valid
         user.destroy!
      end
      it "is invalid when username isn't ALL lowercase" do
         expect(build(:user, username: "Abc")).to_not be_valid
      end
      it "is invalid when username is shorter than 2" do
         expect(build(:user, username: "a")).to_not be_valid
      end
      it "is invalid when username is longer than 20" do
         expect(
            build(:user, username: "abcdeabcdeabcdeabcdef")
               ).to_not be_valid
      end

      # First name
      it "is invalid without first name" do
         expect(build(:user, first_name: nil)).to_not be_valid
      end
      it "is invalid when first name doesn't start with a capital" do
         expect(build(:user, first_name: "abc")).to_not be_valid
      end 

      # Last name
      it "is invalid without last name" do
         expect(build(:user, last_name: nil)).to_not be_valid
      end
      it "is invalid when last name doesn't start with a capital" do
         expect(build(:user, last_name: "abc")).to_not be_valid
      end

      # Initials
      it "is invalid without initials" do
         expect(build(:user, initials: nil)).to_not be_valid
      end
      it "is invalid when initials isn't ALL capital" do
         expect(build(:user, initials: "aBC")).to_not be_valid
      end
      it "is invalid when initials is longer than 5" do
         expect(build(:user, initials: "abcdef")).to_not be_valid
      end

      # Nickname
      it "is invalid without nickname" do
         expect(build(:user, nickname: nil)).to_not be_valid
      end

      # Email
      it "is invalid without email" do
         expect(build(:user, email: nil)).to_not be_valid
      end
      it "is invalid if not from @varland.com" do
         expect(
            build(:user, email: 'something@somethingelse.com')
               ).to_not be_valid
      end

      # Avatar bg color
      it "is invalid without avatar bg color" do
         expect(build(:user, avatar_bg_color: nil)).to_not be_valid
      end
      it "is invalid when avatar bg color is not a 6 digit hex code" do
         expect(build(:user, avatar_bg_color: "#fffff")).to_not be_valid
      end

      # Avatar text color
      it "is invalid without avatar text color" do
         expect(build(:user, avatar_text_color: nil)).to_not be_valid
      end
      it "is invalid when avatar hex color is not a 6 digit hex code" do
         expect(build(:user, avatar_text_color: "#fffff")).to_not be_valid
      end

      # Phone number
      it "is invalid without phone number" do
         expect(build(:user, phone_number: nil)).to_not be_valid
      end
      it "is invalid if less than 10 digits" do
         expect(build(:user, phone_number: "123456789")).to_not be_valid
      end
      it "is invalid if more than 10 digits" do
         expect(build(:user, phone_number: "12345678901")).to_not be_valid
      end
   end

   # Associations
   describe "Associations" do
      it { assoc = described_class.reflect_on_association(:vat_history_notes)
         expect(assoc.macro).to eq :has_many }
      it { assoc = described_class.reflect_on_association(:assigned_permissions)
         expect(assoc.macro).to eq :has_many }
      it { assoc = described_class.reflect_on_association(:permissions)
         expect(assoc.macro).to eq :has_many }
      it { assoc = described_class.reflect_on_association(:employee_notes)
         expect(assoc.macro).to eq :has_many }
      it { assoc = described_class.reflect_on_association(:authored_employee_notes)
         expect(assoc.macro).to eq :has_many }
      it { assoc = described_class.reflect_on_association(:clock_records)
         expect(assoc.macro).to eq :has_many }
      it { assoc = described_class.reflect_on_association(:thickness_blocks)
         expect(assoc.macro).to eq :has_many }
      it { assoc = described_class.reflect_on_association(:print_queue_rules)
         expect(assoc.macro).to eq :has_many }
   end

   # Scoping Class Methods
   describe User, '.enabled' do
      it 'returns only active users (is_disabled: false)' do
         user1 = create(:user)
         user2 = create(:user, employee_number: 2, username: "abc", is_disabled: true)
         expect(User.enabled).to include(user1)
         expect(User.enabled).to_not include(user2)

         # Teardown
         user1.destroy!
         user2.destroy!
      end
   end

   describe User, '.by_name' do
      it "returns users with first, last, nickname, initials, username like " do
         user1 = create(:user, 
               employee_number: 1, 
                      username: 'qwe',  
                    first_name: 'Abc')
         user2 = create(:user, 
               employee_number: 2, 
                      username: 'rty', 
                     last_name: 'Abc')
         user3 = create(:user, 
               employee_number: 3, 
                      username: 'uio', 
                      nickname: 'Abc')
         user4 = create(:user, 
               employee_number: 4, 
                      username: 'pas', 
                      initials: 'ABC')
         user5 = create(:user, 
               employee_number: 5, 
                      username: 'abc')
         user6 = create(:user, 
               employee_number: 6, 
                      username: 'dfg')
         
         expect(User.by_name('abc')).to include(user1, user2, user3, user4, user5)
         expect(User.by_name('abc')).to_not include(user6)

         expect(User.by_name('dfg')).to include(user6)
         expect(User.by_name('dfg')).to_not include(user1, user2, user3, user4, user5)

            # Teardown
            user1.destroy!
            user2.destroy!
            user3.destroy!
            user4.destroy!
            user5.destroy!
            user6.destroy!
      end
   end

   describe User, '.by_category' do
      it "returns users who's employee_number is in SOME range" do
         plater = create(:user, 
                employee_number: 195, 
                       username: 'qwe')
         maintenance = create(:user, 
                employee_number: 250, 
                       username: 'rty')
         lab = create(:user, 
                employee_number: 350, 
                       username: 'uio')
         shipping = create(:user, 
                employee_number: 450, 
                       username: 'pas')
         production = create(:user, 
                employee_number: 700, 
                       username: 'dfg')
         office = create(:user, 
                employee_number: 850, 
                       username: 'hjk')

         expect(
            User.by_category('Plater')
               ).to include(plater)
         expect(
            User.by_category('Plater')
               ).to_not include(maintenance, 
                                lab, 
                                shipping, 
                                production, 
                                office)

         expect(
            User.by_category('Maintenance')
               ).to include(maintenance)
         expect(
            User.by_category('Maintenance')
               ).to_not include(plater, 
                                lab, 
                                shipping,
                                production, 
                                office)

         expect(
            User.by_category('Lab')
               ).to include(lab)
         expect(
            User.by_category('Lab')
               ).to_not include(plater, 
                                maintenance, 
                                shipping, 
                                production, 
                                office)

         expect(
            User.by_category('Shipping/QC')
               ).to include(shipping)
         expect(
            User.by_category('Shipping/QC')
               ).to_not include(plater, 
                                maintenance, 
                                lab, 
                                production, 
                                office)

         expect(
            User.by_category('Production Supervisor')
               ).to include(production)
         expect(
            User.by_category('Production Supervisor')
               ).to_not include(plater, 
                                maintenance, 
                                lab, 
                                shipping, 
                                office)

         expect(
            User.by_category('Office')
               ).to include(office)
         expect(
            User.by_category('Office')
               ).to_not include(plater, 
                                maintenance, 
                                lab, 
                                shipping, 
                                production)

         # Teardown
         plater.destroy!
         maintenance.destroy!
         lab.destroy!
         shipping.destroy!
         production.destroy!
         office.destroy!
      end
   end

   # Non-scoping Class Methods
   describe User, '.digest' do
      it "returns hash digest of a given string" do
         expect(User.digest("test")).to_not equal(User.digest("test"))
      end
   end

   describe User, '.new_token' do
      it "returns a random token" do
         expect(User.new_token).to_not equal(User.new_token)
      end
   end

   # Instance Methods
   describe User, '#remember' do
      it "Generates and stores a persistent login token" do 
         user = create(:user)
         expect(user.remember_digest).to eq(nil)
         user.remember
         expect(user.remember_digest).to_not eq(nil)

         # Teardown
         user.destroy!
      end
   end

   describe User, '#forget' do
      it "removes a users persistent login token" do
         user = create(:user)
         expect(user.remember_digest).to eq(nil)
         user.remember
         expect(user.remember_digest).to_not eq(nil)
         user.forget
         expect(user.remember_digest).to eq(nil)

         # Teardown
         user.destroy!
      end
   end

   describe User, '#full_name' do
      it "returns full name as string" do
         user = build(:user, first_name: "A", 
                              last_name: "B", 
                                 suffix: "C")
         expect(user.full_name).to eq("A B C")
      end
   end

   describe User, '#number_and_name' do
      it "returns employee number - full_name" do
         user = build(:user, first_name: "A", 
                              last_name: "B", 
                                 suffix: "C", 
                        employee_number: 1)
         expect(user.number_and_name).to eq("1 - A B C")
      end
   end

   describe User, '#badge' do
      it "returns the html for a bootstrap badge" do
         user = build(:user)
         expect(user.badge).to include('<span class="badge badge-pill')
      end
   end

   # Ignored: authenticate, authenticated?
end