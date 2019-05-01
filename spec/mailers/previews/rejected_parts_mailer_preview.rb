class RejectedPartsMailer < ActionMailer::Preview
  def send_rejected_part
    part_info = { shopOrder: "", customer: "", processCode: "", partID: "", subID: "" }
    part = Qc::RejectedPart.first
    RejectedPartsMailer.send_rejected_part(part, part_info)
  end
end