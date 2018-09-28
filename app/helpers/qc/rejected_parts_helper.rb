module Qc::RejectedPartsHelper
  require "base64"
  def gen_pdf(rejected_part)

    hash ||= { :form_type     => "Rejected Parts",
               :current_page  => "1",
               :total_pages   => "1",
               :sec1_title    => "Section 1 - Identification & Description",
               :sec1_flavour  => "(All information in this section MUST be filled out at the time of rejection.)",
               :revision_date => "08/08/18 by Brian Mangold",
               :sec2_title    => "Section 2 - Approval without RW",
               :sec2_flavour  => "(Rarely used.)",
               :sec3_title    => "Section 3 - Load Specific Info",
               :sec3_flavour  => "(Use if barrel or station are possible causes of defect.)",
               :sec4_title    => "Section 4 - Cause of Defect/Problem"}
    prev = 0

    pdf = Prawn::Document.new
      prev = pdf.cursor

      # Title.
      pdf.pad(5) { pdf.text "<strong>#{hash[:form_type]}</strong>", 
        :align => :center, 
        :size => 16,
        :inline_format => true }
      
      pdf.move_cursor_to prev

      pdf.pad(5) { pdf.text "<sub>Latest Revision: #{hash[:revision_date]}</sub>", 
        :align => :left, 
        :size => 12,
        :inline_format => true}
      pdf.move_down 3

      pdf.move_down 15

      pdf.fill_color '000000'
      
      # Section 1 header.
      pdf.pad(5) { pdf.text "<strong><u>#{hash[:sec1_title]}</strong></u> <sub> #{hash[:sec1_flavour]} </sub>", 
        :align => :left, 
        :size => 13,
        :inline_format => true} 

      prev = pdf.cursor
      
      # Section 1, center column.
      pdf.bounding_box([pdf.bounds.right/3, prev], 
        :width => pdf.bounds.right/3) do

        pdf.pad(5) { pdf.text "Reject Tag #: <strong>#{rejected_part.reject_tag_num}</strong>",
          :align => :left,
          :size => 12,
          :inline_format => true }

        pdf.pad(5) { pdf.text "Weight: <strong>#{rejected_part.weight}</strong> lbs",
        :align => :left,
        :size => 12,
        :inline_format => true }
      end

      pdf.move_cursor_to prev
      
      # Section 1, right column.
      pdf.bounding_box([pdf.bounds.right*2/3, prev], 
        :width => pdf.bounds.right/3) do

        pdf.pad(5) { pdf.text "Date: <strong>#{rejected_part.date.strftime("%m/%d/%y")}</strong>",
        :align => :left,
        :size => 12,
        :inline_format => true }

        pdf.pad(5) { pdf.text "Rejected By: <strong>#{User.find(rejected_part.user_id).full_name}</strong>",
        :align => :left,
        :size => 12,
        :inline_format => true }

        pdf.pad(5) { pdf.text "<strong>Supervisor Initials:</strong>__________",
        :align => :left,
        :size => 12,
        :inline_format => true }
      end

      pdf.move_cursor_to prev

      # Section 1, left column.
      pdf.pad(5) { pdf.text "VMS S.O. #: <strong>#{rejected_part.so_num}</strong>", 
        :align => :left, 
        :size => 12,
        :inline_format => true }

      

      pdf.pad(5) { pdf.text "From: <strong>#{rejected_part.from_tag}</strong>",
      :align => :left,
      :size => 12,
      :inline_format => true }

      pdf.bounding_box([0, pdf.cursor], 
        :width => pdf.bounds.right*2/3) do

        pdf.pad(5) { pdf.text "Defect: <strong>#{rejected_part.defect}</strong>",
        :align => :left,
        :size => 12,
        :inline_format => true }

      end

      pdf.stroke_color 'd3d3d3'
      pdf.stroke_horizontal_rule
      pdf.stroke_color '000000'   

      pdf.move_down 15

      # Section 2 header.
      pdf.pad(5) { pdf.text "<u><strong>#{hash[:sec2_title]}</u></strong> <sup>#{hash[:sec2_flavour]}</sup>", 
      :align => :left, 
      :size => 13,
      :inline_format => true } 

      prev = pdf.cursor

      # Section 2.
      pdf.bounding_box([0, pdf.cursor], 
        :width => pdf.bounds.right/3) do

        pdf.pad(5) { pdf.text "Loads Approved: <strong></strong>",
          :align => :left,
          :size => 12,
          :inline_format => true }
      end

      pdf.move_cursor_to prev
      
      pdf.bounding_box([pdf.bounds.right/3, pdf.cursor], 
        :width => pdf.bounds.right*2/3) do

        pdf.pad(5) { pdf.text "Approved By:",
          :align => :left,
          :size => 12,
          :inline_format => true }
      end

      pdf.pad(5) { pdf.text "Comments: <strong></strong>",
        :align => :left,
        :size => 12,
        :inline_format => true}
      pdf.move_down 40


      pdf.stroke_color 'd3d3d3'
      pdf.stroke_horizontal_rule
      pdf.stroke_color '000000'
      pdf.move_down 15

      # Section 3 header.
      pdf.pad(5) { pdf.text "<u><strong>#{hash[:sec3_title]}</u></strong> <sup> #{hash[:sec3_flavour]}</sup>", 
      :align => :left, 
      :size => 13,
      :inline_format => true } 

      if rejected_part.s3box
        prev = pdf.cursor

        # Section 3.
          if rejected_part.load_nums.blank?
          else
            loads = rejected_part.load_nums.split(", ")
            puts loads
            tanks = rejected_part.tank_nums.split(", ")
            puts tanks
            barrels = rejected_part.barrel_nums.split(", ")
            puts barrels

            lvals = ["Load #:"]
            tvals = ["Tank:"]
            bvals = ['Barrel:']
            count = loads.count

            count.times do |i|
              lvals << loads[i]
              tvals << tanks[i]
              bvals << barrels[i]
            end


            pdf.table( [lvals, tvals, bvals] )
            pdf.move_down 10
          end

      else
        pdf.pad(5) { pdf.text "Not used.",
          :align => :left,
          :size => 12,
          :inline_format => true} 
      end

      pdf.stroke_color 'd3d3d3'
      pdf.stroke_horizontal_rule
      pdf.stroke_color '000000'
      pdf.move_down 15
      

      # Section 4
      pdf.pad(5) { pdf.text "<strong><u>#{hash[:sec4_title]}</strong></u>", 
        :align => :left, 
        :size => 13,
        :inline_format => true }

        prev = pdf.cursor

      pdf.bounding_box([pdf.bounds.right/3, prev], 
        :width => pdf.bounds.right*2/3) do
          pdf.pad(5) { pdf.text "Cause: <strong>#{rejected_part.cause}</strong>",
            :align => :left,
            :size => 12,
            :inline_format => true}
        end
      e = pdf.cursor
      pdf.bounding_box([0, prev], 
        :width => pdf.bounds.right/3) do
          pdf.table([['Cleaning'        , "    "],
                     ['Equipment'       , "    "],
                     ['Operator Error'  , "    "],
                     ['Procedure Wrong' , "    "],
                     ['Solution Related', "    "],
                     ['Wrong Process'   , "    "],
                     ['Other'           , "    "]])
        end

      if e < prev
        pdf.move_down 10
      else 
        pdf.move_cursor_to prev-10       
      end
      
      pdf.stroke_color 'd3d3d3'
      pdf.stroke_horizontal_rule
      pdf.stroke_color '000000'
      
      # string = pdf.render_file("hello.pdf")
      string = pdf.render()

      raw_data = ""
      raw_data << "data:image/jpeg;base64,"
      raw_data << Base64.encode64(string)


      data = {}
      data[:file] = raw_data
      data[:user_id] = rejected_part.user_id
      data[:document_type_id] = 8
      
      puts data

      printjob = Printing::PrintJob.new(data)
      puts printjob
      if printjob.save
        Printing::PrintJob.set_queue(printjob)
        Printing::PrintJob.send_print_cmd(printjob)
      end
  end      
end