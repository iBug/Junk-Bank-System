# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  { name: '科大总行', city: '合肥', assets: 10000 },
  { name: '微软支行', city: '北京', assets: 8888 },
  { name: '电磁炮支行', city: '杭州', assets: 6666 },
  { name: '清华支行', city: '北京', assets: 4444 },
].each { |h| Branch.create h }

[
  { name: 'Taoky Strong', kind: '强部' },
  { name: 'Monthly Cards', kind: '胩部' },
  { name: 'FLXG', kind: '强部' },
].each { |h| Department.create h }

[
  { name: 'TaoKY', person_id: '1234-STRONG', phone: '1234-8888', address: '233 Strong City, Arstotzka', start_date: '2020-02-29', manager: true, branch_id: 1, department_id: 1 },
  { name: 'ZJX', person_id: '6666-MONTH', phone: '1234-9999', address: '233 Cards Rd, S', start_date: '2000-01-01', manager: false, branch_id: 1, department_id: 2 },
  { name: 'CWK', person_id: '3594-FLXG', phone: '2333-2333', address: '1st Teaching Bldg, USTC', start_date: '1958-01-01', manager: false, branch_id: 3, department_id: 3 },
  { name: 'Volltin', person_id: 'AAAA-ZZZZ', phone: '0000-0000', address: 'Hello, world!', start_date: '2016-09-01', manager: true, branch_id: 2, department_id: 1 },
  { name: 'Steve', person_id: 'player-1', phone: '87654321-0', address: 'Overworld', start_date: '2011-11-18', manager: true, branch_id: 4, department_id: 3 },
  { name: 'Franklin Clinton', person_id: 'OXOX-NGGA', phone: '(555)555-1234', address: '3671 Whispymound Drive, Vinewood Hills, Los Santos', start_date: '2013-09-17', manager: true, branch_id: 3, department_id: 1 },
].each { |h| Staff.create h }
