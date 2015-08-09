module ApplicationHelper
  # Return page title
  def title title=""
    title.empty? ? "Framgia E-learning" : title
  end

  # Return the coresponded CSS id selector of the given object
  # Example:
  #   Parameter: an user object with id is 1
  #   Result: "#user_1"
  def dom_id_for object
    "##{dom_id object}"
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new()
    id = new_object.object_id
    # abort("#{id}")
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    # abort("#{fields}")
    link_to(name, '#', class: "add-fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

end
