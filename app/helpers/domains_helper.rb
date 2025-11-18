module DomainsHelper
  def sort_link_to(title, column)
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}, class: class_names(column, "font-bold" => column == sort_column)
  end
end
