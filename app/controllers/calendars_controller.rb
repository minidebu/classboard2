class CalendarsController < ApplicationController
  def index
    make_students_month(calendar_params)
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
   
    @month_plans.where.not(one_week_id:1).group(:st_time,:week_id).count.each do |mpc|  
      name =mpc[0][0].strftime("%k:%M") + " #{mpc[1].to_s}人"
      Plan.create(name:name,start_time:date_from_week(1,mpc[0][1] ,s_date,mpc[0][0]),count:mpc[1],week_id:mpc[0][1],st_time:mpc[0][0],num_week:1)
    end
    @month_plans.where.not(two_week_id:1).group(:st_time,:week_id).count.each do |mpc|  
      name =mpc[0][0].strftime("%k:%M") + " #{mpc[1].to_s}人"
      Plan.create(name:name,start_time:date_from_week(2,mpc[0][1] ,s_date,mpc[0][0]),count:mpc[1],week_id:mpc[0][1],st_time:mpc[0][0],num_week:1)
    end
    @month_plans.where.not(three_week_id:1).group(:st_time,:week_id).count.each do |mpc|  
      name =mpc[0][0].strftime("%k:%M") + " #{mpc[1].to_s}人"
      Plan.create(name:name,start_time:date_from_week(3,mpc[0][1] ,s_date,mpc[0][0]),count:mpc[1],week_id:mpc[0][1],st_time:mpc[0][0],num_week:1)
    end
    @month_plans.where.not(four_week_id:1).group(:st_time,:week_id).count.each do |mpc|  
      name =mpc[0][0].strftime("%k:%M") + " #{mpc[1].to_s}人"
      Plan.create(name:name,start_time:date_from_week(4,mpc[0][1] ,s_date,mpc[0][0]),count:mpc[1],week_id:mpc[0][1],st_time:mpc[0][0],num_week:1)
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



  def make_students_month(s_date)

    ApplicationRecord.connection.create_table('month_plans', temporary: true, force: true )do |t|
    t.integer :student_id
    t.string  :name
    t.integer :week_id
    t.string  :week
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
        MonthPlan.create(student_id:student.id,name:stu_tt.student.name,week_id:stu_tt.time_table.week_id,week:stu_tt.time_table.week.name, 
          st_time:stu_tt.time_table.st_time,one_week_id:stu_sd.schedule.one_week_id,two_week_id:stu_sd.schedule.two_week_id,
          three_week_id:stu_sd.schedule.three_week_id,four_week_id:stu_sd.schedule.four_week_id)
      end
    end
    @month_plans = MonthPlan.all
  end




end