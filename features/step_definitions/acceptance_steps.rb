Given "there are nodes" do
  @nodes = create_list(:node, 7)
  @exta_nodes = create_list(:node, 2)
end

Given "there are tags" do
  @tags = create_list(:tag, 2)
  @ad_tag = create(:tag, name: "adastral_park")
end

Given "there are links between those nodes and tags" do
  @nodes[0..4].each do |node|
    create(:link, node: node, tag: @tags[0])
  end
  
  @nodes[4..6].each do |node|
    create(:link, node: node, tag: @tags[1])
  end
  
  @nodes.each do |node|
    create(:link, node: node, tag: @ad_tag)
  end
end

When "I request a set of tags from the api" do
  visit "dashboard/adastral_park"
end

Then "I recieve the nodes as a list, grouped by tag" do
  expect().to be_json_eql({
    nodes: @nodes,
    tags: @tags
  }.to_json)
end