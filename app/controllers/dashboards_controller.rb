class DashboardsController < ApplicationController
  def show
    tag = Tag.find_by(name: params[:id])
    nodes = Link.where(tag_id: tag.id).map { |l| NormalizedNode.new(l) }
    @dashboard = Dashboard.new(nodes)
  end
end