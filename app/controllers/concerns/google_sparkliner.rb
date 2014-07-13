class GoogleSparkliner
	def initialize(item, width)
		@item = item
		@width = width
	end

	def draw
		data_table = GoogleVisualr::DataTable.new
	  data_table.new_column("number", "Activity" )
	  data_table.add_rows(60)
	  (0..(@item.sparkline_points.length - 1)).each do |i|
	    data_table.set_cell(i,0,@item.sparkline_points[i])
	  end
	  opts   = { width: @width, height: 60, showAxisLines: false,  showValueLabels: true, labelPosition: 'none' }
	  GoogleVisualr::Image::SparkLine.new(data_table, opts)
	end

	def draw_random
		data_table = GoogleVisualr::DataTable.new
    data_table.new_column("number", "% Saturated" )
    data_table.add_rows(60)
    (0..59).each do |i|
      data_table.set_cell(i,0,rand(100))
    end
    opts   = { width: @width, height: 60, showAxisLines: false,  showValueLabels: true, labelPosition: 'none' }
	  GoogleVisualr::Image::SparkLine.new(data_table, opts)
	end
end