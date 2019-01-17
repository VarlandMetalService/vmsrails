class FileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end



  version :thumb, if: :is_img? do
    process :resize_to_fit => [200, 5000]
  end

  def extension_white_list
    %w(jpg jpeg gif png doc xls docx xlsx pdf mov mp4 tiff txt md)
  end

protected

  def is_img? file
    file.content_type.start_with?('image')
  end

end