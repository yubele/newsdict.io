class GenerateDicsJob < ApplicationJob
  queue_as :mecab_dics
  # Update mecab dic
  # @param [Configs::MecabDic]
  def perform(mecab_dic)
    decompress_command = get_decompress_command(mecab_dic.url)
    # The reason to use curl is to prevent Memory Allocate
    if decompress_command
      system("curl #{mecab_dic.url} | #{decompress_command} > /tmp/#{mecab_dic.key}")
    else
      system("curl #{mecab_dic.url} > /tmp/#{mecab_dic.key}")
    end
    # Create dic-index from csv
    CSV.open("/tmp/#{mecab_dic.key}.csv", 'w') do |csv|
      open("/tmp/#{mecab_dic.key}").each_with_index do |keyword, index|
        keyword.chomp!
        next if index == 0 && mecab_dic.is_header
        next if keyword =~ %r{mecab_dic.regex_for_ignore_line}
        if keyword.length > 3
          score = [-36000.0, -400 * (keyword.length ** 1.5)].max.to_i
          csv << [keyword, nil, nil, score, '名詞', '一般', '*', '*', '*', '*', keyword, '*', '*', mecab_dic.key]
        end
      end
    end
    stdout_str, stderr_str, status = Open3.capture3("#{Newsdict::Application.config.path_of_mecab_dict_index} -d /usr/share/mecab/dic/ipadic -f utf-8 -t utf-8 -u #{Newsdict::Application.config.path_of_mecab_dict_dir}/#{mecab_dic.key}.dic /tmp/#{mecab_dic.key}.csv")
    raise "#{stderr_str}:#{stdout_str} #{Newsdict::Application.config.path_of_mecab_dict_index} -d /usr/share/mecab/dic/ipadic -f utf-8 -t utf-8 -u #{Newsdict::Application.config.path_of_mecab_dict_dir}/#{mecab_dic.key}.dic /tmp/#{mecab_dic.key}.csv" unless status.success?
    File.unlink("/tmp/#{mecab_dic.key}", "/tmp/#{mecab_dic.key}.csv")
  end
  # Get command
  # @param String url
  # @return String extenion
  def get_decompress_command(url)
    url.strip!
    if url =~ /.tar.gz$/
      "tar -zxf"
    elsif url =~ /.zip$/
      "unzip"
    elsif url =~ /.gz$/
      "gunzip"
    elsif url =~ /.bzip2$/
      "bzip2 -d"
    else
      nil
    end
  end
end