class MmmsController < InheritedResources::Base
  before_action :authenticate_user!

  def index
    redirect_to new_user_session_path unless current_user
  end
  private

  def mmm_params
    params.require(:mmm).permit(:title, :content)
  end
end
