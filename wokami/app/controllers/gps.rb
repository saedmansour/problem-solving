module Gps

  def get_user_recommended_paths(subject_id)
    answers_array = get_user_answers
    subject       = Subject.find(subject_id) 

    recommended_paths = []
    subject.posts.each do |post|
      path_answers = get_learning_path_answers(post.id)
      if array_include(answers_array, path_answers)  
        recommended_paths.push(post)
      end
    end

    return recommended_paths
  end

  def get_user_recommended_flows(subject_id)
    answers_array = get_user_answers
    subject       = Subject.find(subject_id) 

    recommended_flows = []
    subject.flows.each do |flow|
      path_answers = get_learning_flow_answers(flow.id)
      if array_include(answers_array, path_answers)  
        recommended_flows.push(flow)
      end
    end

    return recommended_flows
  end
  
  def add_learing_path_answers (post_id, answers_ids)
    answers_ids.each do |answer_id|
      PostAnswers.new(answer_id: answer_id, post_id: post_id)
    end
  end

  def get_learning_path_answers (post_id)
    return PostAnswers.where(post_id: post_id).map { |p| p.answer_id }
  end

  def get_learning_flow_answers (flow_id)
    return FlowAnswers.where(flow_id: flow_id).map { |f| f.answer_id }
  end

  def get_user_answers
    return cookies[:answers_ids].split(%r{,\s*}).drop(1).map{|s| s.to_i}
  end

  # returns true if left_array subset of right_array
  def array_include(a1, a2) 
    return (a1 - a2).empty?
  end

end
