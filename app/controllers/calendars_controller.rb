class CalendarsController < ApplicationController
  before_action :set_beginning_of_week

  def index
    make_students_month(calendar_params)
    make_calendar_table(calendar_params)


    if params[:s_day].present?
      make_students_day(params[:s_day])
      partial = render_to_string(partial:'footer', :locals => { day_plans:@day_plans })
      render json:{html:partial}    
    end

  end

  private
  # １日分の生徒リストを出す
  def make_students_day(s_day)
      num_week = week_from_date(s_day)
    @day_plans = [] 
    
    case num_week[:num] 
    when 1 then
      d_plans =  @month_plans.where(week_id: num_week[:wday]).where.not(one_week_id:1)
      d_plans.order(st_time:"ASC").each do |d_plan|
        @day_plans <<{name:d_plan.name,st_time:d_plan.st_time,lesson_id:d_plan.one_week_id}
      end
    when 2 then
      d_plans =  @month_plans.where(week_id: num_week[:wday]).where.not(two_week_id:1)
      d_plans.order(st_time:"ASC").each do |d_plan|
        @day_plans <<{name:d_plan.name,st_time:d_plan.st_time,lesson_id:d_plan.two_week_id}
      end
    when 3 then
      d_plans =  @month_plans.where(week_id: num_week[:wday]).where.not(three_week_id:1)
      d_plans.order(st_time:"ASC").each do |d_plan|
        @day_plans <<{name:d_plan.name,st_time:d_plan.st_time,lesson_id:d_plan.three_week_id}
      end
    when 4 then
      d_plans =  @month_plans.where(week_id: num_week[:wday]).where.not(four_week_id:1)
      d_plans.order(st_time:"ASC").each do |d_plan|
        @day_plans <<{name:d_plan.name,st_time:d_plan.st_time,lesson_id:d_plan.four_week_id}
     
      end
    end
  end





  # 日付から曜日と何周目かを返す
  def week_from_date(s_day)
    d_day = Date.parse(s_day)
    # その月の週数と日曜始まりにする調整
    beginning_of_month_cweek = d_day.beginning_of_month.cweek - 1
     if d_day.beginning_of_month.wday > d_day.wday && d_day.wday != 0
      beginning_of_month_cweek += 1 
     end
    nth = d_day.cweek - beginning_of_month_cweek
    nth = s_day.ago(1.week).to_date.cweek - beginning_of_month_cweek if nth.negative?
    

    d_wday = d_day.wday
    if d_wday == 0
      d_wday = 7
    end

    return { num: nth, wday: d_wday }
  end

  # シンプルカレンダーを日曜始まりにする
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

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
   
    @month_plans.where.not(one_week_id:1).group(:st_time,:week_id).count.each do |mpc|  
      name =mpc[0][0].strftime("%k:%M") + " #{mpc[1].to_s}人"
      Plan.create(name:name,start_time:date_from_week(1,mpc[0][1] ,s_date,mpc[0][0]),count:mpc[1],week_id:mpc[0][1],st_time:mpc[0][0],num_week:1)
    end
    @month_plans.where.not(two_week_id:1).group(:st_time,:week_id).count.each do |mpc|  
      name =mpc[0][0].strftime("%k:%M") + " #{mpc[1].to_s}人"
      Plan.create(name:name,start_time:date_from_week(2,mpc[0][1] ,s_date,mpc[0][0]),count:mpc[1],week_id:mpc[0][1],st_time:mpc[0][0],num_week:2)
    end
    @month_plans.where.not(three_week_id:1).group(:st_time,:week_id).count.each do |mpc|  
      name =mpc[0][0].strftime("%k:%M") + " #{mpc[1].to_s}人"
      Plan.create(name:name,start_time:date_from_week(3,mpc[0][1] ,s_date,mpc[0][0]),count:mpc[1],week_id:mpc[0][1],st_time:mpc[0][0],num_week:3)
    end
    @month_plans.where.not(four_week_id:1).group(:st_time,:week_id).count.each do |mpc|  
      name =mpc[0][0].strftime("%k:%M") + " #{mpc[1].to_s}人"
      Plan.create(name:name,start_time:date_from_week(4,mpc[0][1] ,s_date,mpc[0][0]),count:mpc[1],week_id:mpc[0][1],st_time:mpc[0][0],num_week:4)
    end

    @plans = Plan.all
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


  # 一ヶ月分の生徒情報すべて
  def make_students_month(s_date)

    ApplicationRecord.connection.create_table('month_plans', temporary: true, force: true )do |t|
    t.integer :student_id
    t.string  :name
    t.integer :week_id
    t.time    :st_time
    t.integer :one_week_id
    t.integer :two_week_id
    t.integer :three_week_id
    t.integer :four_week_id
    t.timestamps
    end
    Object.const_set('MonthPlan', Class.new(ApplicationRecord))


    # 退会していない生徒
    students = Student.where(withdrawal_on:nil).or(Student.where('withdrawal_on >= ?',s_date.beginning_of_month))
    
    students.each do |student|
      # 退会していない人で今月お稽古があるテーブルを取得
      stu_tts= student.student_time_tables.where('started_on <= ? ',s_date.end_of_month)
      stu_sds= student.student_schedules.where('started_on <= ? ',s_date.end_of_month)
      stu_tt = {}
      stu_sd = {}
      # 今月内にテーブル両方あればmonthplanに登録する
      if stu_tts.present? && stu_sds.present?
  
        stu_tt = stu_tts.where('started_on <= ? ',s_date.beginning_of_month).last
        stu_sd = stu_sds.where('started_on <= ? ',s_date.beginning_of_month).last
        MonthPlan.create(student_id:student.id,name:stu_tt.student.name,week_id:stu_tt.time_table.week_id,
          st_time:stu_tt.time_table.st_time,one_week_id:stu_sd.schedule.one_week_id,two_week_id:stu_sd.schedule.two_week_id,
          three_week_id:stu_sd.schedule.three_week_id,four_week_id:stu_sd.schedule.four_week_id)
      end
    end
    @month_plans = MonthPlan.all
  end




end