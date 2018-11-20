module ApplicationHelper
  include Admin::UsersHelper

  # Formatting
  def highlight_unless_nil(text, terms, options = { highlighter: '<mark class="bold">\1</mark>' })
    return text if terms.nil?
    highlight(text, terms[:include], highlighter: options[:highlighter])
  end

  def required_field_label(text)
    (text + content_tag(:sup, fa_icon('asterisk'), 
              class: ['text-danger'], 
              style: "font-size: 10px;")).html_safe
  end

  def small_label_bold_text(label, text)
    "<small>#{label}:</small> <strong>#{text}</strong>".html_safe
  end

  def date_and_time(datetime)
    "#{datetime.strftime('%D')}
    <br>
    #{datetime.strftime('%I:%M %p')}".html_safe
  end

  # CHANGE THIS should be in opto helper
  # def opto_email_field_value(label, value)
  #   "<small style=\"font-weight: 300; font-size: 0.85rem;\">#{label}:</small> <span style=\"color: #e83e8c; font-family: SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace; font-size: 0.875rem; font-weight: 700;\">#{value}</span>".html_safe
  # end

  def split_search_terms(input)
    search = {
      include: [],
      exclude: []
    }
    terms = input.split(/\s(?=(?:[^"]|"[^"]*")*$)/)
    terms.each do |t|
      if t[0..1] == '--'
        search[:exclude] << t[2..-1].gsub(/\A"|"\Z/, '')
      else
        search[:include] << t.gsub(/\A"|"\Z/, '')
      end
    end
    search
  end

  def paginator(collection)
    if collection.blank?
      "<p class='text-danger'>No results found.</p>".html_safe
    else
      "<p class='font-weight-bold'>
          #{ page_entries_info collection }
          #{ paginate collection }
      </p>".html_safe
    end
  end

  def bottom_paginator(collection)
    if collection.blank?
    else
      "<p class='font-weight-bold'>
          #{ page_entries_info collection }
          #{ paginate collection }
      </p>".html_safe
    end
  end
end
