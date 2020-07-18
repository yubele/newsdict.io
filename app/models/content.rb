class Content < ApplicationRecord
  include Mongoid::Document
  has_one :source
  has_one :user
  field :title, type: String
  field :site_name, type: String
  field :content, type: String
  field :expanded_url, type: String
  # image blob (because active-storage is not support mongoid.)
  field :image_blob, type: BSON::Binary
  field :image_svg, type: String
  field :tags, type: Array
  field :http_status, type: Integer
  field :language_code, type: String
  field :source_id, type: BSON::ObjectId
  field :user_id, type: BSON::ObjectId
  field :count_of_shared, type: Integer
  # unique id of source
  field :unique_id, type: String
  include Mongoid::Timestamps
  belongs_to :source, optional: true
  belongs_to :user, optional: true
  validates_uniqueness_of :unique_id, :allow_nil => true
  validates :language_code, length: {minimum: 2, maximum: 2}
  validates :unique_id, length: {maximum: 255}
  SORT_TYPE = {
    :created_at => {created_at: :desc},
    :updated_at => {updated_at: :desc},
    :count_of_shared => {count_of_shared: :desc}
  }
  # Get tags longer than a certain number of characters
  # @param [Integer] number tag length
  def longer_tags(number = 3)
    tags.map {|tag| tag if tag.length >= number }.compact.reject(&:empty?)
  end
  # Deduce page num from a model given a scope
  # ref: https://github.com/kaminari/kaminari/issues/205
  # @params [Array] options
  # @return [Integer] page number
  def page_num(options = {})
    column = options[:by] || :id
    order  = options[:order] || :asc
    per    = options[:per] || self.class.default_per_page
  
    operator = (order == :asc ? "<=" : ">=")
    (self.class.where("#{column} #{operator} ?" => read_attribute(column)).order("#{column} #{order}").count.to_f / per).ceil
  end
  
  class << self
    # Set attributes by `WebStat` gems
    # @param [Source] object
    # @param [Object] web_stat
    # @return [Hash] attributes
    def set_attributes_by_web_stat(object, web_stat)
      attrs = {
        :title => web_stat[:title],
        :site_name => web_stat[:site_name],
        :content => web_stat[:content],
        :expanded_url => web_stat[:url],
        :http_status => web_stat[:status],
        :language_code => web_stat[:language_code],
        :tags => web_stat[:tags],
        :source_id => object.id,
        :user_id => object.user_id
      }
      # image
      unless web_stat[:eyecatch_image_path].nil?
        blob = File.read(web_stat[:eyecatch_image_path])
        begin
          # Binary
          image = MiniMagick::Image.read(blob)
          image.resize "128x"
          attrs[:image_blob] = BSON::Binary.new(image.to_blob)
        rescue
          # Svg
          attrs[:image_svg] = blob
        end
      end
      attrs
    end
    # Save a content from job
    # @param [Hash] attrs
    # @return [void] 
    def save_form_job(attrs)
      already_content = Contents::Web.unique?(url: attrs[:exclude_url], title: attrs[:title])
      # Check duplicated contents
      if already_content && already_content.source.update?(already_content, attrs)
        already_content.update_attributes(attrs)
        already_content.inc(count_of_shared: 1)
      else
        # Translate
        if attrs[:language_code] != ENV["default_locale"] && EasyTranslate.api_key.present?
          attrs[:title] = EasyTranslate.translate(attrs[:title], :to => ENV["default_locale"])
        end
        content = Contents::Web.new(attrs)
        content.count_of_shared = 1
        content.save
      end
    end
    # Get the records
    # @param order default :desc
    # @param category_id default: nil
    # @return [Contents::Web] 
    def contents(order: :desc, category_id: nil, name: nil)
      if name
        collection = self.in(source_id: Source.find_by(name: name))
      elsif category_id
        collection = self.in(source_id: Source.where(category_id: category_id).map {|u| u.id })
      else
        collection = self.in(source_id: Source.all.map {|u| u.id })
      end
      collection = collection.where(http_status: "200")
      if ::Filters::HiddenContent.exists?
        collection
          .not(expanded_url: /(#{::Filters::HiddenContent.all.map {|c| c.exclude_url }.join('|')})/)
          .not(expanded_title: /(#{::Filters::HiddenContent.all.map {|c| c.exclude_title }.join('|')})/)
      else
        collection.all
      end
    end
    # Sort the content by sort_type
    # @param [Symbol] sort_type
    # @return [Contents::Web] 
    def sortable(sort_type=:updated_at)
      if Content::SORT_TYPE.key?(sort_type)
        sort_type_sym = sort_type.to_sym
      end
      order_by(*Content::SORT_TYPE[sort_type_sym])
    end
    # Get the data of between gt and lte
    # @params [String] gt 
    # @params [String] lte
    # @return [Contents::Web] 
    def term(gt, lte, key = :updated_at)
      gt(key => gt).lte(key => lte)
    end
    # If it return a content, instance is uniq contents.
    #  Perfect matching `extended_url` or Perfect matching `title`
    # @param [String] url
    # @param [String] title
    # @return [Content] exists content
    def unique?(url: nil, title: nil)
      where(expanded_url: url).first || where(title: title).first
    end
  end
end