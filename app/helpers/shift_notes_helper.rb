module ShiftNotesHelper

  # Decorators
    def filter_link(attribute, attribute_name)
      if attribute.blank? || attribute_name.blank?
      else
        "<a href='#' 
          data-#{attribute_name}='#{attribute}' 
                          title='Filter by #{attribute_name} #{attribute} ' 
                          class='#{attribute_name}-filter font-weight-bold'> 
          #{attribute} </a>".html_safe
      end
    end
  
    def button_group(note)
      "<div class='btn-group-vertical' role='group'>
        #{link_to fa_icon('eye'),
              shift_note_path(note),
              class: 'font-weight-bold btn btn-sm btn-success',
              title: 'View Shift Note',
              data: { toggle: 'tooltip' }}
        #{ if @access_level >= 0
          link_to fa_icon('pencil'),
            edit_shift_note_path(note),
            class: 'font-weight-bold btn btn-sm btn-warning',
            title: 'Edit Shift Note',
            data: { toggle: 'tooltip' }
        end }
        #{ if @access_level >= 0
          link_to fa_icon('times'),
            shift_note_path(note),
            method: :delete,
            class: 'font-weight-bold btn btn-sm btn-danger',
            title: 'Delete Shift Note',
            data: { confirm: 'Are you sure you want to delete this shift note?',                            toggle: 'tooltip' }
        end }
      </div>".html_safe
    end

  def prod_date
    t = Time.now
    if t.hour < 7 || t.hour > 23
      return Date.yesterday
    else  
      return Date.today
    end
  end

  def prod_shift
    t = Time.now
    if t.hour < 7 || t.hour > 23
      return 3
    elsif t.hour >= 7 && t.hour <= 15
      return 1
    else
      return 2
    end
  end

  def attachment_area(c)
    if c.attachment?
      message = 
      "<td>
          <button class='btn btn-block float-right' style='background-color: #DDDDDD; border-color: #dee2e6;' type='button' data-toggle='collapse' data-target='.multi-collapse#{c.id}' style='font-size: 11px;'>
              #{fa_icon('paperclip')}
          </button>
        </td>
      </tr>".html_safe
      c.attachment.each do |f| 
      message += "<tr class='collapse multi-collapse#{c.id} bg-white'>
          <td colspan='3' class='text-center px-0'>
            <a href='#{f.url}' target='_blank'>#{image_tag(f.url, size: '320') unless f.blank?}</a>
          </td>
        </tr>".html_safe
      end
    else
      message = "<td></td>
      </tr>"
    end
    return message.html_safe
  end
end
