class DashboardsController < ApplicationController
  def show
    query = params[:query].split("/")
    and_query = query[0].split("+")
    filter_query = query[1..-1].to_a
    nodes = and_query.map { |q|
      tags = Tag.where(name: q)
      tags.map { |tag|
        Link.where(tag_id: tag.id)
        .map { |l| NormalizedNode.new(l) }
      }
    }.flatten
    unless filter_query.empty?
      filtered_nodes = nodes.select { |n|
        filter_query.all? { |q|
          n.tags.values.include? q
        }
      }
    else
      filtered_nodes = nodes
    end
    @dashboard = Dashboard.new(filtered_nodes)
  end
end
