class Content < ApplicationRecord
  include Mongoid::Document
  has_one :source
  has_one :user
  field :title, type: String
  field :site_name, type: String
  # deprecated
  field :content, type: String, default: ""
  field :content_text, type: String, default: ""
  field :shared_text, type: String, default: ""
  field :expanded_url, type: String
  # image blob (because active-storage is not support mongoid.)
  field :image_blob, type: BSON::Binary
  field :image_svg, type: String
  field :tags, type: Array
  field :raw_data, type: String
  field :http_status, type: Integer
  field :language_code, type: String
  field :source_id, type: BSON::ObjectId
  field :user_id, type: BSON::ObjectId
  field :count_of_shared, type: Integer
  field :unique_id, type: String
  field :last_modified_at, type: DateTime
  include Mongoid::Timestamps
  belongs_to :source, optional: true
  belongs_to :user, optional: true
  validates_uniqueness_of :unique_id, :allow_nil => true
  validates :language_code, length: {minimum: 2, maximum: 2}
  validates :unique_id, length: {maximum: 255}
  validates :shared_text, length: { minimum: 0, allow_nil: false, message: "can't be nil" }
  SORT_TYPE = {
    :last_modified_at => {last_modified_at: :desc},
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
    column = attributes.keys.find{|v| v==options[:by].to_s } || :id
    order  = options[:order] == :desc ? :desc : :asc
    per    = options[:per] || self.class.default_per_page
    operator = (order == :asc ? "<=" : ">=")
    (self.class.where("#{column} #{operator} ?" => read_attribute(column)).order("#{column} #{order}").count.to_f / per).ceil
  end
  
  # Crawl original URL
  #  Implement in child class.
  # @return [String] url
  def source_url; end

  class << self
    # Set attributes by `WebStat` gems
    # @param [Source] object
    # @param [Object] web_stat
    # @return [Hash] attributes
    def set_attributes_by_web_stat(object, web_stat)
      attrs = {
        :title => web_stat[:title],
        :site_name => web_stat[:site_name],
        :content_text => web_stat[:content],
        :expanded_url => web_stat[:url],
        :http_status => web_stat[:status],
        :language_code => web_stat[:language_code],
        :tags => web_stat[:tags],
        :source_id => object.id,
        :user_id => object.user_id,
        :last_modified_at => web_stat[:last_modified_at]
      }
      # Add the tags
      web_stat[:tags].each do |name|
        CollectTag.add(name)
      end
      # image
      if web_stat[:eyecatch_image_path]
        blob = File.read(web_stat[:eyecatch_image_path])
        begin
          # Binary
          image = MiniMagick::Image.read(blob)
          image.resize "364x"
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
      already_content = unique?(url: attrs[:exclude_url], title: attrs[:title])
      # Check duplicated contents
      if already_content && already_content.source.update?(already_content, attrs)
        already_content.update_attributes(attrs)
        already_content.inc(count_of_shared: 1)
      elsif already_content&.unique_id != attrs[:unique_id].to_s
        # Translate
        if attrs[:language_code] != ENV["default_locale"] && EasyTranslate.api_key.present?
          attrs[:content_text] = EasyTranslate.translate(attrs[:content_text], :to => ENV["default_locale"])
        end
        content = new(attrs)
        content.count_of_shared = 1
        content.save
      end
    end
    # Get the records
    # @param [Symbol] order default :desc
    # @param [BSON::ObjectId] category_id default: nil
    # @param [String] name of Source
    # @return [Content]
    def contents(order: :desc, category_id: nil, name: nil)
      if name
        collection = self.in(source_id: Source.find_by(name: name))
      elsif category_id
        collection = self.in(source_id: Source.where(category_id: category_id).map {|u| u.id })
      else
        collection = self.in(source_id: Source.pluck(:id))
      end
      collection = collection.where(http_status: "200")
      unless ::Filters::HiddenContent.regexp(:exclude_url).blank?
        collection = collection.not(expanded_url: ::Filters::HiddenContent.regexp(:exclude_url))
      end
      unless ::Filters::HiddenContent.regexp(:exclude_title).blank?
        collection = collection.not(title: ::Filters::HiddenContent.regexp(:exclude_title))
      end
      collection
    end
    # Sort the content by sort_type
    # @param [Symbol] sort_type
    # @return [Content]
    def sortable(sort_type=:last_modified_at)
      if Content::SORT_TYPE.key?(sort_type)
        sort_type_sym = sort_type.to_sym
      end
      order_by(*Content::SORT_TYPE[sort_type_sym])
    end
    # Get the data of between gt and lte
    # @params [String] gt
    # @params [String] lte
    # @return [Contents]
    def term(gt, lte, key = :last_modified_at)
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
    # Search content by title
    # @param [String] keyword
    # @return [Content]
    def search_by_title(keyword)
      self.where(title: /#{keyword}/)
    end
    # Search content by tag
    # @param [String] keyword
    # @return [Content]
    def search_by_tag(keyword)
      self.in(:tags => keyword)
    end
    # Search content by category_name
    # @param [String] keyword
    # @return [Content]
    def search_by_category_name(keyword)
      category_ids = Configs::Category.where(key: /#{keyword}/).map(&:id)
      source_ids = Source.in(category_id: category_ids).map(&:id)
      self.where(:source_id.in => source_ids)
    end
    # Search content by mixed
    # @param [String] keyword
    # @return [Content]
    def search_by_mixed(keyword)
      self.any_of(
        self.search_by_title(keyword),
        self.search_by_tag(keyword),
        self.search_by_category_name(keyword))
    end
  end
end