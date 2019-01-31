class RejectedPartsMailer < ApplicationMailer
  helper :application

  # Define layout.
  layout('reject_tag_mailer')

  default from: 'varlandmetalservice@gmail.com',
            to: 'Rejected Parts <richard.legacy@varland.com>'
            
  def send_rejected_part(part, part_info)
    @part = part
    @part_info = part_info
    @section_header_style = "border: 2px solid #000; border-bottom-width: 0; padding: 0.5rem 1rem; text-align: left; color: #fff; background-color: #222; font-weight: bold; text-transform: uppercase; font-size: 1.5rem;";
    @table_header_style = "padding: 0.5rem; background-color: #900000; color: #fff; font-weight: bold; text-transform: uppercase; border: 2px solid #000; font-size: 1rem;";
    @centered_cell_style = "color: #000; text-align: center; font-weight: bold; padding: 0.5rem; border: 2px solid #000;"
    @left_cell_style = "color: #000; text-align: left; font-weight: bold; padding: 0.5rem; border: 2px solid #000;"
    @zero_height_cell_style = "font-size: 0; height: 0; line-height: 0; padding: 0;"
    subject_parts = [@part_info[:customer], @part_info[:processCode], @part_info[:partID]]
    unless @part_info[:subID].blank?
      subject_parts << @part_info[:subID]
    end
    mail(subject: "Reject Tag #{@part.so_num}##{@part.reject_tag_num} (#{subject_parts.join(', ')})")
  end
end