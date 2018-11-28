require 'rails_helper'

RSpec.describe ShiftNote do
  # Validations
  describe "Validations" do
    it "has a valid factory" do
      expect(build_stubbed(:shift_note)).to be_valid
    end
    # User/user_id
    it "is invalid without user_id/user" do
      expect(build_stubbed(:shift_note, user_id: nil)).to_not be_valid
    end
    # dept
    it "is invalid without dept" do
      expect(build_stubbed(:shift_note, dept: nil)).to_not be_valid
    end
    # shift_time
    it "is invalid without shift_time" do
      expect(build_stubbed(:shift_note, shift_time: nil)).to_not be_valid
    end
    # shift_type
    it "is invalid without shift_type" do
      expect(build_stubbed(:shift_note, shift_type: nil)).to_not be_valid
    end
  end

  # Associations
  describe "Associations" do
    it { assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to }
    it { assoc = described_class.reflect_on_association(:comments)
      expect(assoc.macro).to eq :has_many }
  end

  # Scoping class methods
  describe ShiftNote, '.with_timestamp' do
    it "returns records created after X datetime" do
      note1 = create(:shift_note )
      note2 = create(:shift_note, 
              user: note1.user, 
        created_at: (DateTime.now - 2.days)) 

      expect(ShiftNote.with_timestamp(DateTime.now - 1.day)).to include(note1)
      expect(ShiftNote.with_timestamp(DateTime.now - 1.day)).to_not include(note2)

      # Teardown
      note1.user.destroy!
      note1.destroy!
      note2.destroy!
    end
  end
  describe ShiftNote, '.with_user' do
    it "returns records with X user" do
      note1 = create(:shift_note, user_id: 1)
      note2 = create(:shift_note, user_id: 2)

      expect(ShiftNote.with_user(1)).to include(note1)
      expect(ShiftNote.with_user(1)).to_not include(note2)

      # Teardown
      note1.user.destroy! unless note1.user.blank?
      note2.user.destroy! unless note2.user.blank?
      note1.destroy!
      note2.destroy!
    end
  end
  describe ShiftNote, '.with_dept' do
    it "returns records with X dept" do
      note1 = create(:shift_note, dept: 1 )
      note2 = create(:shift_note, dept: 2, user: note1.user )

      expect(ShiftNote.with_dept(1)).to include(note1)
      expect(ShiftNote.with_dept(1)).to_not include(note2)

      # Teardown
      note1.user.destroy!
      note1.destroy!
      note2.destroy!
    end
  end
  describe ShiftNote, '.with_shift_type' do
    it "returns records with X shift_type" do
      note1 = create(:shift_note, shift_type: 'Lab')
      note2 = create(:shift_note, shift_type: 'IT', user: note1.user)

      expect(ShiftNote.with_shift_type('Lab')).to include(note1)
      expect(ShiftNote.with_shift_type('Lab')).to_not include(note2)

      # Teardown
      note1.user.destroy!
      note2.user.destroy!
      note1.destroy!
      note2.destroy!
    end
  end
  describe ShiftNote, '.with_shift_time' do
    it "returns records with X shift_time" do
      note1 = create(:shift_note, shift_time: 1)
      note2 = create(:shift_note, shift_time: 2, user: note1.user)

      expect(ShiftNote.with_shift_time(1)).to include(note1)
      expect(ShiftNote.with_shift_time(1)).to_not include(note2)

      note1.user.destroy!
      note1.destroy!
      note2.destroy!
    end
  end
  describe ShiftNote, '.sorted_by' do
    context "returns records ordered by updated at" do
      it "when sent 'oldest' returns records ordered by updated_at" do
        note1 = create(:shift_note, updated_at: DateTime.now)
        note2 = create(:shift_note, updated_at: (DateTime.now - 2.days), user: note1.user)

        expect(ShiftNote.sorted_by('oldest')).to eq([note2, note1])
        expect(ShiftNote.sorted_by('oldest')).to_not eq([note1, note2])

        # Teardown
        note1.user.destroy!
        note1.destroy!
        note2.destroy!
      end
      it "else returns records ordered by updated_at desc" do
        note1 = create(:shift_note, updated_at: DateTime.now)
        note2 = create(:shift_note, updated_at: (DateTime.now - 2.days), user: note1.user)

        expect(ShiftNote.sorted_by('')).to_not eq([note2, note1])
        expect(ShiftNote.sorted_by('')).to eq([note1, note2])

        # Teardown
        note1.user.destroy!
        note1.destroy!
        note2.destroy!
      end
    end
  end
  describe ShiftNote, '.with_search_term' do
    it "returns records with a message like X" do 
      note1 = create(:shift_note, message: 'abc')
      note2 = create(:shift_note, message: 'xyz', user: note1.user)

      expect(ShiftNote.with_search_term('abc')).to eq([note1])
      expect(ShiftNote.with_search_term('abc')).to_not eq([note2])
      expect(ShiftNote.with_search_term('xyz')).to eq([note2])
      expect(ShiftNote.with_search_term('xyz')).to_not eq([note1])

      # Teardown
      note1.user.destroy!
      note1.destroy!
      note2.destroy!
    end
  end

  # Non-scoping class methods
  describe ShiftNote, '.options_for' do
    context "returns arrays for filter forms" do
      it "returns user array when sent 'user'" do
        expect(ShiftNote.options_for("user")).to eq([])
      end
      it "returns sorted by array when sent 'sorted_by'" do
        expect(ShiftNote.options_for("sorted_by")).to eq([['Newest', 'newest'],
                                                          ['Oldest', 'oldest']])
      end
      it "returns shift_time array when sent 'shift_time'" do
        expect(ShiftNote.options_for("shift_time")).to eq([['1', '1'],
                                                           ['2', '2'],
                                                           ['3', '3']])
      end
      it "returns shift_type array when sent 'shift_type'" do
        expect(
          ShiftNote.options_for("shift_type")
              ).to eq([['IT',                   'IT'],
                       ['Lab',                 'Lab'],
                       ['Maintenance', 'Maintenance'],
                       ['Plating',         'Plating'],
                       ['QC',                   'QC'],
                       ['Shipping',       'Shipping']])
      end
      it "returns dept array when sent 'dept'" do
        expect(ShiftNote.options_for("dept")).to eq([['Dept. 3',      '3'],
                                                     ['Dept. 5',      '5'],
                                                     ['Dept. 6',      '6'],
                                                     ['Dept. 7',      '7'],
                                                     ['Dept. 4',      '4'],
                                                     ['Dept. 8',      '8'],
                                                     ['Dept. 10',    '10'],
                                                     ['Dept. 12',    '12'],
                                                     ['Waste Water', '30']])
      end
    end
  end

end