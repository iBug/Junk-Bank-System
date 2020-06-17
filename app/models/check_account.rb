class CheckAccount < ApplicationRecord
  include Accountable
  set_display_name '支票账户'
end
