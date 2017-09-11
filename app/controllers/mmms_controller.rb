class MmmsController < InheritedResources::Base
  before_action :authenticate_user!

  def index
    # @mmms = mmm.all
    # case @mmms
    # when "spring" then
    # link_to edit_mmm_path
    redirect_to new_user_session_path unless current_user
  end
  private

  def mmm_params
    params.require(:mmm).permit(:title, :content)
  end
end
