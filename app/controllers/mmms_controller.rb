class MmmsController < InheritedResources::Base

  # def index
  #   @mmms = mmm.all
  #   case @mmms
  #   when "spring" then
  #     link_to
  #   end
  private

  def mmm_params
    params.require(:mmm).permit(:title, :content)
  end
end
