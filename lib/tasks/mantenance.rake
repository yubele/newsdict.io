namespace :maintenance do
  desc "Migrate some to Contents::Tweet."
  task migrate_contents_web: :environment do |task, args|
    Content.all.each do |content|
      if content.source.class == Sources::TwitterAccount
        content._type = "Contents::Tweet"
        content.save
      end
    end
  end
end