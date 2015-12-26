class NormalizedNode
  attr_reader :tags, :id

  def initialize link
    node = link.node
    relevant_links = Link.where(node_id: node.id)
    @tags = relevant_links
      .map { |l| [ l.position, l.tag.name ] }
      .to_h
    @id = node.id
  end
end
