class Inquiry < ApplicationRecord
  include Mongoid::Document
  field :name, type: String
  field :mailaddress, type: String
  field :url, type: String
  field :inquiry, type: String
  validates :name, length: {minimum: 2, maximum: 20}, presence: true
  validates :mailaddress, length: {minimum: 3, maximum: 32}, format: { with: /\A[^\s]+@[^\s]+\Z/}, presence: true
  validates :inquiry, length: {minimum: 20}, presence: true
  include Mongoid::Timestamps
end