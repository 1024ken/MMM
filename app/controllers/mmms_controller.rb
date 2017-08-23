class MmmsController < InheritedResources::Base
  private

  def mmm_params
    params.require(:mmm).permit(:title, :content)
  end
end
