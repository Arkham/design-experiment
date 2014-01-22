module MemberHelper
  def member_headers(member)
    [:h1, :h2, :h3].inject("") do |result, header|
      result << content_tag(:p, class: "member_header") do
        "#{header}: #{member.send(header)}"
      end
    end.html_safe
  end

  def member_introduction_path_for(collection)
    collection.map(&:name).join(" > ")
  end
end
