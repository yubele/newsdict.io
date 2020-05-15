migrateds = Array.new
# Deprecated Sources::Url 
if Sources::Url.exists?
    Sources::Url.all.each do |url|
        migrateds << url.attributes
    end
end
# Deprecated Sources::WebUrl
if Sources::WebUrl.exists?
    Sources::WebUrl.all.each do |url|
        migrateds << url.attributes
    end
end
# Deprecated Sources::WebSection
if Sources::WebSection.exists?
    Sources::WebSection.all.each do |url|
        migrateds << url.attributes
    end
end
# Insert to Sources::Web
if migrateds.present?
    migrateds.each do |migrated|
        old_id = migrated.delete("_id")
        migrated.delete("_type")
        migrated.delete("category")
        migrated.delete("url")
        sources_web = Sources::WebSite.new(migrated)
        sources_web.save
        if contents_web = Contents::Web.where(source_id: old_id)
            contents_web.update(source_id: sources_web.id)
        end
    end
    Sources::Url.delete_all
    Sources::WebUrl.delete_all
    Sources::WebSection.delete_all
end