module QueriesHelper
  def part_spec_info(customer, process, part, sub_id, separator = ' &bull; ')
    parts = []
    parts << customer unless customer.blank?
    parts << process unless process.blank?
    parts << part unless part.blank?
    parts << sub_id unless sub_id.blank?
    parts.join(separator).html_safe
  end
end
