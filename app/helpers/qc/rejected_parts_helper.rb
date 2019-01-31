module Qc::RejectedPartsHelper
  require "base64"

  def get_from_tags
    hash = {}
      Qc::RejectedPart.all.map { |x| [x.so_num.to_s, x.reject_tag_num] }.each do |y|
        if hash.has_key?(y[0])
          if hash[y[0]] > y[1]
          else
            hash[y[0]] = y[1]
          end
        else
          hash[y[0]] = y[1]
        end
      end
      return hash
  end

  # Generates PDF, sends to print job controller, returns print_job id
  def gen_pdf(rejected_part)

    pdf = RejectTagPdf.new(rejected_part)
      
      # FOR LOCAL TESTING SWITCH THESE TWO
      # string = pdf.render_file("hello.pdf")
      string = pdf.render()

      raw_data = ""
      raw_data << "data:image/jpeg;base64,"
      raw_data << Base64.encode64(string)

      data = {}
      data[:file] = raw_data
      data[:user_id] = rejected_part.user_id
      data[:document_type_id] = 14
      data[:description] = "RejectTag #{rejected_part.so_num}##{rejected_part.reject_tag_num}"

      printjob = Printing::PrintJob.new(data)
      if printjob.save
        Printing::PrintJob.set_queue(printjob)
        Printing::PrintJob.send_print_cmd(printjob)
      end

      return printjob.id
  end
end