class NormalizedNode
  attr_reader :tags, :id

  def initialize link
    node = link.node
    relevant_links = Link.where(node_id: node.id)
    @tags = relevant_links.map { |l| l.tag.name }
    @id = node.id
  end
end
