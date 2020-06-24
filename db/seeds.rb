require 'faker'

Faker::Config.locale = 'en-US'

NAMES = []
loop do
  NAMES << Faker::TvShows::BigBangTheory.unique.character rescue break
end

def generate_number range
  Faker::Number.within(range: range || (1..10))
end

def generate_staffs count
  NAMES[1..count].map do |name|
    {
      name: name, person_id: Faker::IDNumber.invalid, phone: Faker::PhoneNumber.cell_phone,
      address: Faker::Address.full_address, start_date: Faker::Date.between(from: 3.years.ago, to: 1.day.ago),
      manager: Faker::Boolean.boolean,
      branch_id: Faker::Number.between(from: 1, to: $branches.size),
      department_id: Faker::Number.between(from: 1, to: $departments.size),
    }
  end
end

def generate_contact
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  {
    name: "#{first_name} #{last_name}",
    phone: Faker::PhoneNumber.cell_phone,
    email: "#{first_name.downcase}@#{last_name.downcase}.com",
    relationship: Faker::Relationship.familial,
  }
end

$branches = [
  ['科大总行', '合肥', generate_number(1000..9999)],
  ['清华支行', '北京', generate_number(1000..9999)],
  ['大炮支行', '杭州', generate_number(1000..9999)],
  ['河北支行', '天津', generate_number(1000..9999)],
].each { |a| Branch.create({ name: a[0], city: a[1], assets: a[2] }) }

$departments = [
  ['Taoky Strong', '强部'],
  ['Monthly Cards', '胩部'],
  ['FLXG', '锵部'],
].each { |a| Department.create({ name: a[0], kind: a[1] }) }

generate_staffs(8).each { |h| Staff.create h }

[
  ['Franklin Clinton', '328-555-0156', '3671 Whispymound Drive, Vinewood Hills, Los Santos', 1, 3],
  ['Michael De Santa', '328-555-0108', 'Portola Drive, Rockford Hills, Los Santos', 2, 1],
  ['Trevor Philips', '273-555-0136', 'Zancudo Avenue, Sandy Shores, Blaine County', 1, 2],
  ['Lamar Davis', 'N/A', 'Forum Drive, Strawberry, Los Santos', 1, 1],
  ['Lester Crest', 'N/A', 'Amarillo Vista, El Burro Heights, Los Santos', 6, 2],
  ['Devin Weston', 'N/A', 'Buen Vino Road, Tongva Hills, Los Santos County', 3, 3],
  ['Steve Haines', '328-555-0150', 'Los Santos', 2, 2],
].each { |a| Client.create({ name: a[0], person_id: Faker::IDNumber.invalid, phone: a[1], address: a[2], manager_id: a[3], manager_type: a[4], contact_attributes: generate_contact }) }
