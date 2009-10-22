Factory.define :<%= singular_name %> do |<%= singular_name %>|
<% for attribute in attributes -%>
  <%= singular_name %>.<%= attribute.name %> {Faker::Lorem.words(5).join(' ').titleize}
<% end -%>
end