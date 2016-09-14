#
# TODO: upgrade the current naive implementation:
#   * Store user answers + "solving state"
#
class HomeworkController < ApplicationController	

  def start
  	@homework = Homework.find(params[:id])

  	@question = @homework.questions.first
  	@answers	= @question.answers
  	@solution = @question.answer

  	render plain: "#{@question.id} --- #{@answers.to_a.map { |e| e.id }.join(',')} --- #{@solution.id}"
  end

  def next
  	@homework = Homework.find(params[:id])
  	@question = Question.find(params[:question_id])

  	questions 	= @homework.questions.all.to_a.sort_by {|e| e.id}
  	current_question_idx = questions.index(@question)

  	return finish() if current_question_idx == (questions.length - 1)

  	@next_question = questions[current_question_idx + 1]

  	render plain: "Next question: #{@next_question.id}"
  end

  def finish
  	flash[:alert] = "Horray! Homework finished."
    redirect_to root_path
  end

end