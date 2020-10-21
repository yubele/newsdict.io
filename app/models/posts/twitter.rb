class Posts::Twitter < ::Post
  field :twitter_token_id, type: BSON::ObjectId
  belongs_to :twitter_token, class_name: "Configs::Tokens::Twitter"
end