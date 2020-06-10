class CheckAccount < Account
  set_display_name '支票账户'

  has_one :account, as: :accountable
end
