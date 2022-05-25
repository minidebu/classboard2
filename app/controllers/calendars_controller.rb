class CalendarsController < ApplicationController
  def index
     make_calendar_table(calendar_params)
  end


  private 
  def calendar_params
    if params[:start_date].blank?
   
      return Date.today
    else
      return params[:start_date].to_date
    end

  end


    # カレンダー表示用のテーブルを作成
  def make_calendar_table(s_date)

    ApplicationRecord.connection.create_table('plans', temporary: true, force: true )do |t|
    t.string :name
    t.datetime :start_time
    t.integer :count
    t.integer :week_id
    t.time :st_time
    t.integer :num_week
    t.timestamps
    end

    Object.const_set('Plan', Class.new(ApplicationRecord))
    
    make_plans(s_date)
    
    # お稽古曜日と時間を登録
    plans_index = @plans.uniq(&:time_table_id)
    plans_index.each do |plan_index|
       Plan.create(st_time:plan_index.time_table.st_time,week_id:plan_index.time_table.week_id,count:0)  
    end
    @ca_tables = Plan.all
    # 人数と日付を登録
    @ca_tables.each do |ca_table|
      ca_table.start_time = date_from_week(1, ca_table.week_id,s_date,ca_table.st_time)
      @plans.each do |plan|
        if ca_table.st_time == plan.time_table.st_time && ca_table.week_id == plan.time_table.week_id
          ca_table.count += 1 

        end
      end
      ca_table.name = ca_table.st_time.strftime("%H:%M") + " " + ca_table.count.to_s + "人"
    end 
  end   

# 何周目の何曜日から日付を返す
  def date_from_week(num_week, wday,s_date,st_time)
    if wday == 7
      wday = 0
    end
    d = s_date.beginning_of_month
    first_week = 7 - d.wday
    
    if ( 7 * (1 - 2) + first_week + wday ) < 0
      num_week += 1
    end
    d = d +( 7 * (num_week - 2) + first_week + wday )
  
    DateTime.new(d.year,d.month,d.day,st_time.hour,st_time.min  )
  end

  # 今月のstudent_time_tableをすべて取得
  def make_plans(s_date)
    # 退会していない生徒
    students = Student.where(withdrawal_on:nil).or(Student.where('withdrawal_on >= ?',s_date.beginning_of_month))
    @plans = []
    students.each do |student|
      # 退会していない人のタイムテーブルを取得
      stts= student.student_time_tables.where('started_on <= ? ',s_date.end_of_month)
      # 今月遍歴があれば今月の遍歴すべて取得
      if stts.where('started_on >= ? ',s_date.beginning_of_month).present?
        stts.where('started_on >= ? ',s_date.beginning_of_month).each do |stt| 
          @plans << stt
        end
      end
      # 前月までの最後の遍歴を取得
      if stts.where('started_on < ? ',s_date.beginning_of_month).present?
        @plans << stts.where('started_on < ? ',s_date.beginning_of_month).last
      end
    end
  end

end


