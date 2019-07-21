module Sources
  class TwitterAccount < ::Source
    include ::TwitterConcern
    # Name is twitter's screen_name
    validates :name, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]{1,15}\z/, message: 'twitter\'s screen_name only' }
  end
end