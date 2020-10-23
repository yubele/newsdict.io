FactoryBot.define do
  factory "Posts::Twitter" do
    name {Faker::Name.unique.name}
    body {
      <<~STR
      {date}の記事をまとめてみたよ。
      {recent_tags} {paper_url_for_today}"
      STR
    }
  end
end