require 'ostruct'

class SearchMemberConnections
  attr_accessor :member

  def initialize(member)
    @member = member
  end

  def search_topic(topic)
    ActiveRecord::Base.connection.execute(sql_for(topic)).each_with_object({}) do |item, result|
      item = OpenStruct.new(item)

      result[item.match_id] ||= SearchResult.new({
        path: item.path.scan(/\d+/).map{|id| Member.find(id) },
        match: topic
      })
    end.values
  end

  class SearchResult < OpenStruct; end

  private

  def connection_minimum_depth
    2
  end

  def sql_for(topic)
    like_topic = "%#{topic}%"

    tree_sql = <<-SQL
      WITH RECURSIVE friendship_tree(id, name, match_id, matched_h1, path) AS (
        SELECT id, name, id, CASE WHEN members.h1 LIKE ? then 1 else 0 end, ARRAY[id]
        FROM members
        WHERE members.h1 LIKE ? OR members.h2 LIKE ? OR members.h3 LIKE ?
      UNION ALL
        SELECT members.id, members.name, ft.match_id, ft.matched_h1, members.id || path
        FROM friendship_tree AS ft
        JOIN friendships ON friendships.friend_id = ft.id
        JOIN members ON members.id = friendships.member_id
        WHERE NOT members.id = ANY(path)
      )
      SELECT * FROM friendship_tree
      WHERE id = ? AND array_length(path, 1) > ?
      ORDER BY matched_h1 desc, array_length(path, 1);
    SQL

    ActiveRecord::Base.send(:sanitize_sql_array, [tree_sql,
                                                  like_topic, like_topic, like_topic, like_topic,
                                                  member.id, connection_minimum_depth])
  end
end
