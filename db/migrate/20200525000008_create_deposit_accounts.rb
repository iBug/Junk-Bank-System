class CreateDepositAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :deposit_accounts, comment: '储蓄账户' do |t|
      t.float :interest_rate, comment: '利率'
      t.string :currency, limit: 3, default: 'BTC', comment: '货币类型'
    end
  end
end
