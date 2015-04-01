class TrackerProjectsController < PagesController

  def show
    tracker_api = TrackerAPI.new
    @stories_raw = tracker_api.stories(params[:id].to_i, current_user.token)
    @stories = @stories_raw.sort! { |x,y| y[:created_at] <=> x[:created_at] }
    @tracker_project_name = params[:name]
  end

end
