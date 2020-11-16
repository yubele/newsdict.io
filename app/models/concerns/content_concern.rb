module ContentConcern
  refine Twitter::Tweet do
    # Convert Twitter::Tweet to Contents::Tweet.
    # @return [Array] 'Contens::Tweet's
    def to_content
      urls.map do |url|
        Contents::Tweet.new({
          shared_text: full_text,
          expanded_url: url,
          raw_data: self.to_json
        })
      end
    end
  end
end