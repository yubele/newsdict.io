class Sources::Relations::TwitterAccount < ::Sources::TwitterAccount
  field :source_id, type: BSON::ObjectId
  belongs_to :source
end