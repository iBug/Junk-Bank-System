module LoansHelper
  def status_of(loan)
    case loan.amount_issued
    when 0
      :unissued
    when loan.amount
      :issued
    else
      :issuing
    end
  end

  def status_s(status)
    { unissued: '未发放', issuing: '发放中', issued: '发放完毕' }.fetch status, 'Error'
  end
end
