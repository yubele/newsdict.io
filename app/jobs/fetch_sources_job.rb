class FetchSourcesJob < ApplicationJob
  queue_as :default
  # Fetch the web pages by url
  # @param [Source] object
  # @param [String] url
  def perform(object, url)
    userdics = Hash.new
    Configs::MecabDic.each do |dic|
      userdics[dic.language_code] = File.join(
        Newsdict::Application.config.path_of_mecab_dict_dir,
        "#{dic.key}.dic")
    end
    web_stat = WebStat.stat_by_url(url, userdics: userdics)
    attrs = Contents::Web.set_attributes_by_web_stat(object, web_stat)
    Contents::Web.save_form_job(web_stat, attrs)
  end
end