class Issue < ApplicationRecord
  set_display_name '支付'
  belongs_to :loan
end
