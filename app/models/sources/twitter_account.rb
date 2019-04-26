module Sources
  class TwitterAccount < ::Source
    include ::TwitterConcern
    # Name is twitter's screen_name
    validates :name, uniqueness: true, format: { with: /\A[a-zA-Z]+\z/, message: 'Alphanumeric only' }
  end
end