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
    filter_query.each do |f|
    end
    nodes = nodes.select { |n|
      puts n.tags.values.inspect
      puts filter_query.inspect
      n.tags.values
        .any? { |t| filter_query.include? t }
    }
    @dashboard = Dashboard.new(nodes)
  end
end
