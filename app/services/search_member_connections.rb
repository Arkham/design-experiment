require 'ostruct'

class SearchMemberConnections
  attr_accessor :member

  def initialize(member)
    @member = member
  end

  def search_topic(topic)
    ActiveRecord::Base.connection.execute(sql_for(topic)).map do |result|
      SearchResult.new({
        path: result["path"].scan(/\d+/).map{|id| Member.find(id) },
        match: topic
      })
    end
  end

  class SearchResult < OpenStruct; end

  private

  def sql_for(topic)
    tree_sql = <<-SQL
      WITH RECURSIVE friendship_tree(id, name, path) AS (
        SELECT id, name, ARRAY[id]
        FROM members
        WHERE members.h1 LIKE ?
      UNION ALL
        SELECT members.id, members.name, members.id || path
        FROM friendship_tree
        JOIN friendships ON friendships.friend_id = friendship_tree.id
        JOIN members ON members.id = friendships.member_id
        WHERE NOT members.id = ANY(path)
      )
      SELECT * FROM friendship_tree
      WHERE id = ? AND array_length(path, 1) > 2
      ORDER BY array_length(path, 1);
    SQL

    ActiveRecord::Base.send(:sanitize_sql_array, [tree_sql, "%#{topic}%", member.id])
  end
end
