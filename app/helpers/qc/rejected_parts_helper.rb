module Qc::RejectedPartsHelper

  def gen_pdf(rejected_part)

    hash ||= { :form_type    => "Rejected Parts",
               :approved_by  => "Richard Legacy",
               :current_page => "1",
               :total_pages  => "1",
               :sec1_title   => "Identification & Description",
               :sec1_flavour => "(All information in this section MUST be filled out at the time of rejection.)" }
    prev = 0

    Prawn::Document.generate("hello.pdf") do |pdf|

      # Title.
      pdf.bounding_box([0, pdf.cursor], :width => pdf.bounds.right) do |box|
        pdf.pad(5) { pdf.text "#{hash[:form_type]}", 
          :align => :center, 
          :size => 16 }
        pdf.stroke_bounds
      end

      prev = pdf.cursor

      # Date.
      pdf.bounding_box([0, pdf.cursor], :width => pdf.bounds.right/3) do
        pdf.pad(5) { pdf.text "Date: #{Date.today.strftime('%m-%d-%y')}", :align => :center }
        pdf.stroke_bounds
      end

      # Approved By.
      pdf.bounding_box([pdf.bounds.right/3, prev ], :width => pdf.bounds.right/3) do
        pdf.pad(5) { pdf.text "Approved By: #{User.find(rejected_part.user_id).full_name}", 
          :align => :center}
        pdf.stroke_bounds
      end

      # Page x of y.
      pdf.bounding_box([pdf.bounds.right*2/3, prev ], 
          :width => pdf.bounds.right/3) do
        pdf.pad(5) { pdf.text "Page #{hash[:current_page]} of #{hash[:total_pages]}", :align => :center }
        pdf.stroke_bounds
      end

      pdf.move_down 10

      # Section 1 title and flavour.
      pdf.bounding_box([0, pdf.cursor ], :width => pdf.bounds.right) do
        pdf.pad(5) { pdf.text "Section 1: #{hash[:sec1_title]}", :align => :left, :size => 12 }
        pdf.text_box "#{hash[:sec1_flavour]}",
          :align => :right, 
          :size => 10,
          :at => [pdf.cursor, pdf.cursor + 15 ]
        pdf.stroke_bounds
      end

      prev = pdf.cursor

      pdf.bounding_box([0, pdf.cursor], :width => pdf.bounds.right/4) do
        pdf.pad(5) { pdf.text "VMS S.O. #: <u>#{rejected_part.so_num}</u>", 
          :align => :center,
          :inline_format => true }
          pdf.stroke_bounds
      end

      pdf.bounding_box([pdf.bounds.right*1/4, prev ], 
          :width => pdf.bounds.right/4) do
        pdf.pad(5) { pdf.text "Reject Tag #: <u>#{rejected_part.reject_tag_num}</u>",
          :align => :center,
          :inline_format => true }
          pdf.stroke_bounds
      end

      pdf.bounding_box([pdf.bounds.right*1/2, prev ], 
        :width => pdf.bounds.right/2) do
      pdf.pad(5) { pdf.text "From Original or Reject Tag: <u>#{rejected_part.from_tag}</u>",
        :align => :center,
        :inline_format => true }
        pdf.stroke_bounds
    end

      pdf.bounding_box([0, pdf.cursor ], 
        :width => pdf.bounds.right) do
      pdf.pad(5) { pdf.text "Note: First rework on original S.O. = Reject Tag #1, second rework on original S.O. = Reject Tag #2, etc.",
        :align => :center,
        :inline_format => true,
        :size => 10 }
        pdf.stroke_bounds
    end
        

    end
  end

end