module MaterialsHelper
  def searched_note(n, term)
    if term.blank?
      simple_format n.notes, class: 'mb-0'
    else
      search_terms = split_search_terms(term)
      highlight(simple_format(n.notes, class: 'mb-0'), 
        search_terms[:include], 
        highlighter: '<mark class="bold">\1</mark>')
    end
  end
end