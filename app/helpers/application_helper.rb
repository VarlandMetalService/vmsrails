module ApplicationHelper
  include Admin::UsersHelper

  def highlight_unless_nil(text, terms, options = { highlighter: '<mark class="bold">\1</mark>' })
    return text if terms.nil?
    highlight(text, terms[:include], highlighter: options[:highlighter])
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

  # Only called from this helper...
  def split_numeric_terms(input)
    terms = input.split(/^\s*([>!=<]*)\s*(\d*\.?\d+)\s*(-)?\s*(\d*\.?\d+)?\s*$/)
    search = nil
    functions = {}
    functions['>='] = 'gte'
    functions['>'] = 'gt'
    functions['<='] = 'lte'
    functions['<'] = 'lt'
    functions['='] = 'eq'
    functions['=='] = 'eq'
    functions['!='] = 'ne'
    functions['<>'] = 'ne'
    case terms.size
    when 3
      function ||= functions[terms[1]]
      if function.nil?
        search = {
          function: 'eq',
          value: terms[2]
        }
      else
        search = {
          function: function,
          value: terms[2]
        }
      end
    when 5
      search = {
        function: 'range',
        minimum: terms[2],
        maximum: terms[4]
      }
    end
    return search
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
