class UpdateMecabDicsJob < ApplicationJob
  queue_as :default

  # Update mecab dic
  def perform
    # Each Configs::MecabDic
    Configs::MecabDic.all.map do |mecab_dic|
      UpdateMecabDicJob.perform_later(mecab_dic)
    end
  end
end