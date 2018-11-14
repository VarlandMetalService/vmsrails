module CommentsHelper

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

  def dropdown_list_button(commentable, bool)
    if bool
      "<div class='pull-right'>
        <button class='btn float-right' type='button'
            data-toggle='collapse' data-target='#collapseCommentsList#{commentable.id}' style='font-size: 14x; background-color: #DDDDDD; border-color: #dee2e6;'>
          #{fa_icon('comments-o', text: commentable.comments.length)}
        </button>
      </div>".html_safe
    else
    end
  end

  def delete_button(c)
    if params[:action] == "edit"
      link_to fa_icon('times'),
        comment_path(c),
        method: :delete,
        class: 'font-weight-bold btn btn-sm btn-danger',
        title: 'Delete comment',
          data: { confirm: 'Are you sure you want to delete this comment?', toggle: 'tooltip' }
    end
  end

end