class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user

  def  badge_color
    case status
    when 'not-started'
      'secondary'
    when 'in-progress'
      'info'
    else
      'success'
    end
  end

  def status
    return 'not-started' if tasks.none?
    if tasks.all? {|task| task.complete?}
      'complete' 
    elsif  tasks.any? {|task| task.in_progress? || task.complete?}
      'in-progress'
    else
      'not-started' 
    end
  end

  def percentage_complete
    return 0 if tasks.none?
    complete_task_count = tasks.select{ |task| task.complete?}.count 
   ((complete_task_count.to_f / tasks.count) * 100).round
  end

  def total_complete
    tasks.select{ |task| task.complete?}.count 
  end
  def total_tasks
    tasks.count
  end
end
