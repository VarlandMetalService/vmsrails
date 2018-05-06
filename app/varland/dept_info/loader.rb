require 'json'
require 'net/https'
require 'uri'

class DeptInfo::Loader

  GOOGLE_URL = 'https://script.google.com/macros/s/AKfycbzTh0AjsLVL0kKxdLAM2KDbf5Z3XYmyQMrRdDMo3M3uj2TQkq4/exec'

  def load
    self.retrieve_google_data
    if @google_data
      subfolder_ids = []
      @google_data['subfolders'].each do |sub_folder|
        subfolder_ids << sub_folder['id']
        self.process_folder(sub_folder)
      end
      DeptInfo::Folder.roots.where.not(google_id: subfolder_ids).destroy_all()
    end
    nil
  end

protected

  def process_folder(folder_object, parent = nil)

    # Lookup or create folder.
    folder = DeptInfo::Folder.where(google_id: folder_object['id'],
                                    parent: parent).first()
    if folder.blank?
      folder = DeptInfo::Folder.new()
      folder.name = folder_object['name']
      folder.google_id = folder_object['id']
      folder.parent = parent
      begin
        unless folder.save
          return
        end
      rescue
        return
      end
    end

    # Update or create documents.
    file_ids = []
    folder_object['files'].each do |file|
      document = DeptInfo::Document.where(google_id: file['id'],
                                          folder: folder).first()
      if document.blank?
        document = DeptInfo::Document.new
      end
      document.folder = folder
      document.google_id = file['id']
      document.name = file['name']
      document.is_starred = file['starred']
      document.description = file['description']
      document.contents = file['contents']
      document.content_type = file['type']
      document.url = file['url']
      file_ids << file['id']
      begin
        document.save
      rescue
        next
      end
    end
    folder.documents.where.not(google_id: file_ids).destroy_all()

    # Process subfolders.
    subfolder_ids = []
    folder_object['subfolders'].each do |sub_folder|
      subfolder_ids << sub_folder['id']
      self.process_folder(sub_folder, folder)
    end
    folder.children.where.not(google_id: subfolder_ids).destroy_all()

  end

  def retrieve_google_data
    @google_data = nil
    response = self.fetch(self.class::GOOGLE_URL)
    if (response)
      @google_data = ::JSON.parse(response.body)
    end
  end

  def fetch(url, limit = 10)
    return nil if limit == 0
    uri = ::URI.parse(url)
    http = ::Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = ::Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    case response
    when ::Net::HTTPSuccess
      return response
    when ::Net::HTTPRedirection
      return self.fetch(response['location'], limit - 1)
    else
      response.error!
    end
  end

end