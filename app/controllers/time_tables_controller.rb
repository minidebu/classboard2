class TimeTablesController < ApplicationController
  def create

    @time_table = TimeTable.new(time_table_params)
    @time_table.save
    
  end

  private
  def time_table_params
    params.require(:time_table).permit(:week_id,:st_time)
  end
end
