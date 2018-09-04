module PrintQueue
  class PrintJob < ApplicationRecord
    mount_base64_uploader :file, PrintJobUploader, file_name: -> (u) { u.created_at }
    default_scope { order("created_at DESC") }

    # Collects and returns rules that evaluate to true based on current print job.
    def self.find_applicable_rules(jid)
      job = PrintQueue::PrintJob.find(jid)
      valid_rules ||= []
      PrintQueue::PrintJobRule.all.each do |pjr|
        if(PrintQueue::PrintJob.assess_truth(pjr.id, jid))
          valid_rules << pjr
        end
      end
      return valid_rules
    end

    # Returns true/false for a given rule/job pair.
    def self.assess_truth(rid, jid)
      var1_val = false
      var2_val = false

      rule = PrintQueue::PrintJobRule.find(rid)
      job = PrintQueue::PrintJob.find(jid)
      if(rule.var1_type == 2 && rule.var2_type == 2)
        var1_val = PrintQueue::PrintJob.assess_truth(rule.var1, jid)
        var2_val = PrintQueue::PrintJob.assess_truth(rule.var2, jid)
        return var1_val.send(rule.operator.to_sym, var2_val)
      elsif(rule.var1_type == 0 && rule.var2_type == 1)
        return job.read_attribute(:"#{rule.var2}").to_s.send(rule.operator.to_sym, rule.var1.to_s) unless job.read_attribute(:"#{rule.var2}").blank?
      elsif(rule.var1_type == 1 && rule.var2_type == 0)
        return job.read_attribute(:"#{rule.var1}").to_s.send(rule.operator.to_sym, rule.var2.to_s) unless job.read_attribute(:"#{rule.var1}").blank?
      else
        return false
      end
    end

    # Build and then return lpr command string from valid_rules list.
    def self.build_lpr_command(valid_rules, jid)
      rule_list ||= []
      job = PrintQueue::PrintJob.find(jid)
      lpr_command = "lpr"
      valid_rules.each do |vr|
        if vr.option_flag != nil
          if rule_list.any?{|r| r.option_flag == vr.option_flag}
            rule_list.each do |rule|
              if(rule.option_flag == vr.option_flag && vr.priority > rule.priority)
                rule.option_value = vr.option_value
              end
            end
          else
            rule_list << vr
          end
        end
      end

      rule_list.each do |r|
        if (r.option_flag == "-U" && r.option_value == ":user")
            r.option_value = job.user
        end
        lpr_command << " #{r.option_flag} #{r.option_value}"
      end
      lpr_command << " #{job.file.current_path}" unless job.file.current_path.blank?
      return lpr_command
    end
  end
end