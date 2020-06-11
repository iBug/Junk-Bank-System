class CheckAccount < ApplicationRecord
  set_display_name '支票账户'

  has_one :account, as: :accountable, dependent: :destroy
end
