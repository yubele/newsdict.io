class UpdateMecabDicsJob < ApplicationJob
  queue_as :default

  # Update mecab dic
  def perform
    # Each Configs::MecabDic
    Configs::MecabDic.all.map do |mecab_dic|
      decompress_command = get_decompress_command(mecab_dic.url)
      # The reason to use curl is to prevent Memory Allocate
      system("curl #{mecab_dic.url} | #{decompress_command} > /tmp/#{mecab_dic.key}")
      # Create dic-index from csv
      CSV.open("/mnt/#{mecab_dic.key}.csv", 'w') do |csv|
        open("/tmp/#{mecab_dic.key}").each_with_index do |_keyword, index|
          next if index == 0 && mecab_dic.is_header
          _, keyword = Array(_keyword.strip.match(/#{mecab_dic.regex_for_extract_title}/))
          next if keyword =~ /#{mecab_dic.regex_for_ignore_line}/
    			if keyword.length > 3
    				score = [-36000.0, -400 * (keyword.length ** 1.5)].max.to_i
    				csv << [keyword, nil, nil, score, '名詞', '一般', '*', '*', '*', '*', keyword, '*', '*', mecab_dic.key]
    			end
        end
      end
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