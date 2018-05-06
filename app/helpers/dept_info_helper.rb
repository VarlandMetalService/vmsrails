module DeptInfoHelper

  def document_icon(document)
    case document.content_type
    when 'image/png', 'image/jpeg', 'image/jpg', 'image/gif', 'image/tiff'
      fa_icon('file-image-o', class: 'fa-fw text-warning')
    when 'application/vnd.google-apps.document', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      fa_icon('file-word-o', class: 'fa-fw text-primary')
    when 'application/vnd.google-apps.spreadsheet', 'application/excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      fa_icon('file-excel-o', class: 'fa-fw text-success')
    when 'text/plain'
      fa_icon('file-text-o', class: 'fa-fw')
    when 'application/pdf'
      fa_icon('file-pdf-o', class: 'fa-fw text-danger')
    when 'video/quicktime', 'video/mp4'
      fa_icon('file-video-o', class: 'fa-fw text-info')
    else
      fa_icon('file-o', class: 'fa-fw text-muted')
    end
  end

end