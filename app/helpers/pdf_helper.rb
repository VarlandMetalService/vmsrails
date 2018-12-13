module PdfHelper

  # Searches pdf for VMS#{SO-NUM} and renames file
  def rename_shop_order(file)
    so_regex = /\s*VMS([0-9]{6})\s+/

    1.upto(4) do |i|
      puts Rails.root.join(file.current_path)
      data = File.read(Rails.root.join(file.current_path))
      text = Yomu.read(:text, data)
      match_data = so_regex.match(text)
      if match_data.nil?
        puts("Failure - need to handle.\n")
      else
        puts("S.O. ##{match_data[1]}\n")
      end
    end
  end

end