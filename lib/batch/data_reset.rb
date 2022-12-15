class Batch::DataReset
  def self.data_reset
    unless Member.find_by(account_name: "guestuser")
      p "ゲストユーザーの情報がありません"
    else Member.find_by(account_name: "guestuser").destroy
      p "ゲストユーザーをリセットしました"
    end
  end
end