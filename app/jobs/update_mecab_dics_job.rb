class UpdateMecabDicsJob < ApplicationJob
  queue_as :default

  # Update mecab dic
  def perform
    # Each Configs::MecabDic
    Configs::MecabDic.all.map do |mecab_dic|
      UpdateMecabDicJob.perform_later(mecab_dic)
    end
  end
  
  def get_decompress_command(url)
    url.strip!
    if url =~ /.tar.gz$/
      "tar -zxf"
    elsif url =~ /.zip$/
      "unzip"
    elsif url =~ /.gz$/
      "gunzip"
    else url =~ /.bzip2$/
      "bzip2 -d"
    end
  end
end