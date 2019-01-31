class RejectTagPdf < VarlandPdf

  # Define height of section header.
  SECTION_HEADER_HEIGHT = 0.35
  
  # Constructor.
  def initialize(part)

    # Call parent constructor and store passed data.
    super()
    @part = part

    # Set options.
    @standard_color = '000000'
    @standard_font = 'Helvetica'
    @data_color = '000000'
    @data_font = 'SF Mono'

    # Print employer copies.
    self.print_graphics
    self.print_data

    # Encrypt PDF.
    encrypt_document(owner_password: :random,
                     permissions: {
                       print_document: true,
                       modify_contents: false,
                       copy_contents: true,
                       modify_annotations: false
                     })
      
  end
  
  # Prints data on Reject Tag.
  def print_data

    # Section 1.
    y = 10.75 - SECTION_HEADER_HEIGHT - 0.25
    self.txtb(@part.so_num.to_s, 0.25, y + 0.04, 2, 0.5, 24, :bold, :center, :center, @data_font, @data_color)
    self.txtb(@part.reject_tag_num.to_s, 2.25, y + 0.04, 2, 0.5, 24, :bold, :center, :center, @data_font, @data_color)
    self.txtb(@part.from_tag, 4.25, y + 0.02, 2, 0.5, 12, :bold, :center, :center, @data_font, @data_color)
    self.txtb(@part.date.strftime('%m/%d/%y'), 6.25, y + 0.02, 2, 0.5, 12, :bold, :center, :center, @data_font, @data_color)
    y -= 0.75
    self.txtb("@cust", 0.25, y + 0.02, 2, 0.35, 10, :bold, :center, :center, @data_font, @data_color)
    self.txtb("@proc", 2.25, y + 0.02, 1, 0.35, 10, :bold, :center, :center, @data_font, @data_color)
    self.txtb("@part_id", 3.25, y + 0.02, 4, 0.35, 10, :bold, :center, :center, @data_font, @data_color)
    self.txtb("@sub_id", 7.25, y + 0.02, 1, 0.35, 10, :bold, :center, :center, @data_font, @data_color)
    y -= 0.6
    self.txtb(@part.sec1_loads, 0.25, y + 0.02, 1, 0.35, 10, :bold, :center, :center, @data_font, @data_color)
    self.txtb(helpers.number_with_precision(@part.weight, precision: 2, delimiter: ','), 1.25, y + 0.02, 1, 0.35, 10, :bold, :center, :center, @data_font, @data_color)
    self.txtb(User.find(@part.user_id).display_name, 2.25, y + 0.02, 2.5, 0.35, 10, :bold, :center, :center, @data_font, @data_color)
    self.txtb(@part.defect, 4.75, y + 0.02, 2, 0.35, 10, :bold, :center, :center, @data_font, @data_color)
    y -= 0.6
    self.txtb(@part.defect_description, 0.3, y - 0.05, 7.9, 1, 10, :normal, :left, :top, @data_font, @data_color)

    # Section 2.
    y = 6.85 - SECTION_HEADER_HEIGHT + 0.01
    x = 0.25
    if @part.load_nums.blank? || @part.load_nums == ", "
      loads = ['', '', '', '', '', '', '']
      barrels = ['', '', '', '', '', '', '']
      stations = ['', '', '', '', '', '', '']
    else
      loads = @part.load_nums.split(", ")
      barrels = @part.barrel_nums.split(", ")
      stations = @part.tank_nums.split(", ")
      while loads.length < 7
        loads << ''
      end
      while barrels.length < 7
        barrels << ''
      end
      while stations.length < 7
        stations << ''
      end
    end
    0.upto(6) do |i|
      x += 1
      self.txtb(loads[i], x, y, 1, 0.25, 8, :normal, :center, :center, @data_font, @data_color)
      self.txtb(barrels[i], x, y - 0.25, 1, 0.25, 8, :normal, :center, :center, @data_font, @data_color)
      self.txtb(stations[i], x, y - 0.5, 1, 0.25, 8, :normal, :center, :center, @data_font, @data_color)
    end

    # Section 3.
    causes = ["CLEANING",
              "CUSTOMER ISSUE",
              "DEVELOPMENT",
              "EQUIPMENT",
              "OPERATOR ERROR",
              "OPTO",
              "PART RELATED",
              "S.O. PROCEDURE",
              "SOLUTION",
              "TECHNIQUE",
              "TECHNOLOGY",
              "UNKNOWN",
              "WRONG PROCESS"]
    index = causes.index(@part.cause_category.upcase)
    y = 5.5 - SECTION_HEADER_HEIGHT
    x = 1.75
    self.txtb(@part.cause, 2.3, y - 0.3, 5.9, 2.9, 10, :normal, :left, :top, @data_font, @data_color)
    y -= (index * 0.25)
    self.txtb("×", x, y + 0.02, 0.5, 0.25, 12, :bold, :center, :center, @data_font, @data_color)

  end

  # Prints section header.
  def section_header(y, title)

    # Set up drawing.
    self.line_width = 0.02.in
    color = 'ffffff'

    # Print section header.
    fill_color('000000')
    fill_rectangle([0.25.in, y.in], 8.in, SECTION_HEADER_HEIGHT.in)
    self.hline(0.25, y, 8)
    self.hline(0.25, y - SECTION_HEADER_HEIGHT, 8)
    self.vline(0.25, y, SECTION_HEADER_HEIGHT)
    self.vline(8.25, y, SECTION_HEADER_HEIGHT)
    self.txtb(title, 0.35, y, 7.8, SECTION_HEADER_HEIGHT, 10, :bold, :left, :center, nil, color)

  end
  
  # Prints standard text & graphics on each page.
  def print_graphics

    # Set up drawing.
    self.line_width = 0.02.in

    # Section 1.
    y = 10.75 - SECTION_HEADER_HEIGHT
    fill_color('cccccc')
    fill_rectangle([0.25.in, y.in], 8.in, 0.25.in)
    y -= 0.75
    fill_rectangle([0.25.in, y.in], 8.in, 0.25.in)
    y -= 0.6
    fill_rectangle([0.25.in, y.in], 8.in, 0.25.in)
    y -= 0.6
    fill_rectangle([0.25.in, y.in], 8.in, 0.25.in)
    y += 1.95
    self.hline(0.25, y, 8)
    self.vline(0.25, y, 0.75)
    self.vline(2.25, y, 0.75)
    self.vline(4.25, y, 0.75)
    self.vline(6.25, y, 0.75)
    self.vline(8.25, y, 0.75)
    self.txtb("SHOP ORDER", 0.25, y, 2, 0.25, 8, :bold, :center, :center)
    self.txtb("REJECT TAG #", 2.25, y, 2, 0.25, 8, :bold, :center, :center)
    self.txtb("SOURCE", 4.25, y, 2, 0.25, 8, :bold, :center, :center)
    self.txtb("DATE", 6.25, y, 2, 0.25, 8, :bold, :center, :center)
    y -= 0.25
    self.hline(0.25, y, 8)
    y -= 0.5
    self.hline(0.25, y, 8)
    self.vline(0.25, y, 0.6)
    self.vline(2.25, y, 0.6)
    self.vline(3.25, y, 0.6)
    self.vline(7.25, y, 0.6)
    self.vline(8.25, y, 0.6)
    self.txtb("CUSTOMER CODE", 0.25, y, 2, 0.25, 8, :bold, :center, :center)
    self.txtb("PROCESS", 2.25, y, 1, 0.25, 8, :bold, :center, :center)
    self.txtb("PART ID", 3.25, y, 4, 0.25, 8, :bold, :center, :center)
    self.txtb("SUB ID", 7.25, y, 1, 0.25, 8, :bold, :center, :center)
    y -= 0.25
    self.hline(0.25, y, 8)
    y -= 0.35
    self.hline(0.25, y, 8)
    self.vline(0.25, y, 0.6)
    self.vline(1.25, y, 0.6)
    self.vline(2.25, y, 0.6)
    self.vline(4.75, y, 0.6)
    self.vline(6.75, y, 0.6)
    self.vline(8.25, y, 0.6)
    self.txtb("LOADS", 0.25, y, 1, 0.25, 8, :bold, :center, :center)
    self.txtb("POUNDS", 1.25, y, 1, 0.25, 8, :bold, :center, :center)
    self.txtb("REJECTED BY", 2.25, y, 2.5, 0.25, 8, :bold, :center, :center)
    self.txtb("DEFECT", 4.75, y, 2, 0.25, 8, :bold, :center, :center)
    self.txtb("SUPERVISOR INITIALS", 6.75, y, 1.5, 0.25, 8, :bold, :center, :center)
    y -= 0.25
    self.hline(0.25, y, 8)
    y -= 0.35
    self.hline(0.25, y, 8)
    self.vline(0.25, y, 1.35)
    self.vline(8.25, y, 1.35)
    self.txtb("DESCRIPTION", 0.25, y, 8, 0.25, 8, :bold, :center, :center)
    y -= 0.25
    self.hline(0.25, y, 8)
    y -= 1.1
    self.hline(0.25, y, 8)
    y = 10.75
    self.section_header(y, "SECTION 1 – IDENTIFICATION & DESCRIPTION")

    # Section 2.
    y = 6.85 - SECTION_HEADER_HEIGHT
    fill_color('cccccc')
    fill_rectangle([0.25.in, y.in], 1.in, 0.75.in)
    self.vline(0.25, y, 0.75)
    x = 1.25
    self.vline(x, y, 0.75)
    7.times do
      x += 1
      self.vline(x, y, 0.75)
    end
    self.txtb("LOAD #", 0.3, y, 0.9, 0.25, 8, :bold, :left, :center)
    y -= 0.25
    self.hline(0.25, y, 8)
    self.txtb("BARREL #", 0.3, y, 0.9, 0.25, 8, :bold, :left, :center)
    y -= 0.25
    self.hline(0.25, y, 8)
    self.txtb("STATION #", 0.3, y, 0.9, 0.25, 8, :bold, :left, :center)
    y -= 0.25
    self.hline(0.25, y, 8)
    y = 6.85
    self.section_header(y, "SECTION 2 – LOAD SPECIFIC INFORMATION")

    # Section 3.
    causes = ["CLEANING",
              "CUSTOMER ISSUE",
              "DEVELOPMENT",
              "EQUIPMENT",
              "OPERATOR ERROR",
              "OPTO",
              "PART RELATED",
              "S.O. PROCEDURE",
              "SOLUTION",
              "TECHNIQUE",
              "TECHNOLOGY",
              "UNKNOWN",
              "WRONG PROCESS"]
    y = 5.5 - SECTION_HEADER_HEIGHT
    fill_color('cccccc')
    fill_rectangle([0.25.in, y.in], 1.5.in, 3.25.in)
    fill_rectangle([2.25.in, y.in], 6.in, 0.25.in)
    self.vline(0.25, y, 3.25)
    self.vline(1.75, y, 3.25)
    self.vline(2.25, y, 3.25)
    self.vline(8.25, y, 3.25)
    self.txtb("COMMENTS", 2.25, y, 6, 0.25, 8, :bold, :center, :center)
    y -= 0.25
    self.hline(2.25, y, 6)
    y += 0.25
    13.times do |i|
      self.txtb(causes[i], 0.25, y, 1.5, 0.25, 8, :bold, :center, :center)
      y -= 0.25
      self.hline(0.25, y, 2)
    end
    self.hline(0.25, y, 8)
    y = 5.5
    self.section_header(y, "SECTION 3 – CAUSE OF DEFECT OR PROBLEM")

    # Section 4.
    y = 1.65 - SECTION_HEADER_HEIGHT
    fill_color('cccccc')
    fill_rectangle([0.25.in, y.in], 1.25.in, 0.8.in)
    fill_rectangle([4.25.in, y.in], 1.25.in, 0.3.in)
    self.vline(0.25, y, 0.8)
    self.vline(1.5, y, 0.8)
    self.vline(4.25, y, 0.3)
    self.vline(5.5, y, 0.3)
    self.vline(8.25, y, 0.8)
    self.txtb("LOADS APPROVED", 0.25, y, 1.25, 0.3, 8, :bold, :center, :center)
    self.txtb("APPROVED BY", 4.25, y, 1.25, 0.3, 8, :bold, :center, :center)
    y -= 0.3
    self.hline(0.25, y, 8)
    self.txtb("COMMENTS", 0.25, y, 1.25, 0.5, 8, :bold, :center, :center)
    y -= 0.5
    self.hline(0.25, y, 8)
    y = 1.65
    self.section_header(y, "SECTION 4 – APPROVAL WITHOUT REWORK")

    # Footer.
    self.txtb("Form ID: <strong>Reject Tag</strong>, Approved By: <strong>Toby Varland</strong>, Revision Date: <strong>01/31/19</strong>", 0.25, 0.5, 8, 0.25, 7, :normal, :right, :bottom)

  end
  
end