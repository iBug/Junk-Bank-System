module StatsHelper
  def deposit_chart_data(records)
    a = records.map do |record|
      [record.display_time, record.total_amount]
    end
  end
end
