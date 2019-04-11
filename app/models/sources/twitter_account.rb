module Sources
  class TwitterAccount < ::Source
    include ::TwitterConcern
    include Mongoid::Document
    include Mongoid::Timestamps
  end
end