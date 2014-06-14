class Question < ActiveRecord::Base
  belongs_to :question_type
  belongs_to :answer_type
  belongs_to :unit
  has_many :question_answer_options, -> { order "question_answer_options.created_at" }
  has_many :answer_options, through: :question_answer_options
  has_many :answers
  has_many :in_edges, class_name: "QuestionEdge", foreign_key: "child_question_id"
  has_many :out_edges, class_name: "QuestionEdge", foreign_key: "parent_question_id"
  belongs_to :question_help_message

  def next_question(question_flow)
    candidate_edges = QuestionEdge.where(parent_question_id: self[:id], question_flow_id: question_flow.id)
    candidate_edges.first
  end

  def previous_question(question_flow)
    candidate_edges = QuestionEdge.where(child_question_id: self[:id], question_flow_id: question_flow.id)
    candidate_edges.first
  end

  def user_answer(answer_session)
    answers.where(answer_session_id: answer_session.id).first
  end

  def answer_frequencies
    groups = answers.group_by{|answer| answer.value}
    groups.inject({}) {|h, (k,v)| h[k] = v.length; h}

  end

end
