class Origin < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  field :unique_id, type: String
  field :object, type: Hash
end