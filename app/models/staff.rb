class Staff < Person
  set_display_name '员工'

  belongs_to :branch
  belongs_to :department
end
