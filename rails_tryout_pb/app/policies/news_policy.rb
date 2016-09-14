class NewsPolicy
  attr_reader :user, :news

  def initialize(user, news)
    @user = user
  end

  def index?
    user.admin? or user.teacher?
  end

  def show?
    true
  end

end