class MecabDicsJob < ApplicationJob
  # Update mecab dic
  def perform
    # Each Configs::MecabDic
    Configs::MecabDic.all.map do |mecab_dic|
      GenerateDicsJob.perform_later(mecab_dic)
    end
  end
end