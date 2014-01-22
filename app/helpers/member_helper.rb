module MemberHelper
  def member_headers(member)
    [:h1, :h2, :h3].each_with_object("") do |header, result|
      content = member.send(header)

      if content.present?
        result << content_tag(:p, class: "member_header") do
          "#{header}: #{content}"
        end
      end
    end.html_safe
  end

  def member_introduction_path_for(collection)
    collection.map(&:name).join(" > ")
  end
end
