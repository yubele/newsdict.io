if Sources::Url.exists?
    # Sources::Url -> Sources::WebUrl
    Sources::Url.all.each do |url|
        migrated = url.attributes
        old_id = migrated.delete("_id")
        migrated.delete("_type")
        migrated.delete("category")
        migrated.delete("url")
        web_url = Sources::WebUrl.new(migrated)
        web_url.save
        if web = Contents::Web.where(source_id: old_id)
            web.update(source_id: web_url.id)
        end
    end
    Sources::Url.delete_all
end