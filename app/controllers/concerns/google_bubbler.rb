class GoogleBubbler
	def initialize(users)
		@users = users
	end

	def scatter_options
    {width: '100%', height: 400,
     fontSize: 16,
     sizeAxis: { maxSize: 40, minSize: 5 },
     chartArea: { width: "85%", height: "85%" },
     legend: { position: 'none'},
     colorAxis: { colors: ['white', '#003399'] },
     hAxis: { title: 'Linked devices',
              titleTextStyle: { fontSize: 18 },
              logScale: false,
              textPosition: "none",
              viewWindowMode: 'pretty',
              gridlines: { color: 'white' } },
     vAxis: { title: 'Linked reagents',
              titleTextStyle: { fontSize: 18 },
              logScale: false,
              textPosition: 'none',
              viewWindowMode: 'pretty',
              gridlines: { color: 'white' } } }
  end

	def draw
		data_table_lab = GoogleVisualr::DataTable.new
    data_table_lab.new_column('string', 'Name')
    data_table_lab.new_column('number', 'Devices')
    data_table_lab.new_column('number', 'Reagents')
    data_table_lab.new_column('number', 'pts/day')
    data_table_lab.new_column('number', 'Total points')
    data_table_lab.add_rows(@users.map { |u|[u.fullname,
                                             u.cached_device_count,
                                             u.cached_reagent_count,
                                             u.cached_daily_points,
                                             u.cached_total_points] })    
    GoogleVisualr::Interactive::BubbleChart.new(data_table_lab, scatter_options)
	end
end