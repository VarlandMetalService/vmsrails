module ShiftNotesHelper

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

end
