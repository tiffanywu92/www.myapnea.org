class QuestionFlow < ActiveRecord::Base
  belongs_to :first_question, class_name: "Question"

  def total_time
    QuestionEdge.where(question_flow_id: self.id).map(&:child_question).uniq.map(&:time_estimate).reduce(:+) + first_question.time_estimate
  end
end
