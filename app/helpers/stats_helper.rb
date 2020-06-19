module StatsHelper
  def deposit_amount_chart(records)
    total_amount = records.map { |record| [record.display_time, record.total_amount] }
    [{ name: '业务额', data: total_amount }]
  end

  def deposit_clients_chart(records)
    clients_count = records.map { |record| [record.display_time, record.clients_count] }
    [{ name: '客户数', data: clients_count }]
  end
end
