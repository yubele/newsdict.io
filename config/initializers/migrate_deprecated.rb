if Sources::Url.exists?
    # Sources::Url -> Sources::WebUrl
    Sources::Url.all.each do |url|
        migrated = url.attributes
        migrated.delete("_id")
        migrated.delete("_type")
        migrated.delete("category")
        migrated.delete("url")
        Sources::WebUrl.new(migrated).save
    end
    Sources::Url.delete_all
end