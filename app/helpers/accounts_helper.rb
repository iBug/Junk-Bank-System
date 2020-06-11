module AccountsHelper
  def account_type_name(s)
    case s
    when 'DepositAccount'
      '储蓄账户'
    when 'CheckAccount'
      '支票账户'
    else
      'Invalid'
    end
  end
end
