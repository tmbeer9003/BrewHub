class Batch::DataReset
  def self.data_reset
    Member.find_by(account_name: "guestuser").destroy
    p "ゲストユーザーをリセットしました"
  end
end