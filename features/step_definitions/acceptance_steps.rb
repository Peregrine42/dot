Given "there are nodes" do
  @foo_nodes = create_list(:node, 4)
  @bar_nodes = create_list(:node, 3)
  @exta_nodes = create_list(:node, 2)
end

Given "there are tags" do
  @foo_tag = create(:tag, name: "foo")
  @bar_tag = create(:tag, name: "bar")
  @ad_tag = create(:tag, name: "adastral_park")
end

Given "there are links between those nodes and tags" do
  @foo_nodes.each do |node|
    create(:link, node_id: node.id, tag_id: @foo_tag.id)
  end
  
  @bar_nodes.each do |node|
    create(:link, node_id: node.id, tag_id: @bar_tag.id)
  end
  
  (@bar_nodes + @foo_nodes).each do |node|
    create(:link, node_id: node.id, tag_id: @ad_tag.id)
  end
end

When "I request a set of tags from the api" do
  visit "dashboards/adastral_park.json"
end

Then "I recieve the nodes as a list, grouped by tag" do
  prepared_foo_nodes = @foo_nodes.map { |n| 
    { "id" => n.id, 
      "name" => n.name, 
      "tags" => [@foo_tag.name] + ["adastral_park"] } 
  }
  prepared_bar_nodes = @bar_nodes.map { |n| 
    { "id" => n.id, 
      "name" => n.name, 
      "tags" => [@bar_tag.name] + ["adastral_park"] } 
  }
  prepared_nodes = (prepared_foo_nodes + prepared_bar_nodes)
  actual_json = JSON.parse(page.body)
  expected = prepared_nodes.map { |n| n["name"] }.sort
  actual = actual_json["nodes"].map { |n| n["name"] }.sort
  
  expect(actual).to eq expected
end