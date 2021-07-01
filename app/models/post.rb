class Post < ApplicationRecord
  using BindingPostConcern
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :body, type: String
  
  belongs_to :hook, class_name: "Configs::Hook", required: false
  belongs_to :schedule, class_name: "Configs::Schedule", required: false
  
  validates :name, presence: true
end