class RSS < Feed
  has_many :headlines, :foreign_key => "feed_id"
end
