require "factory_girl"
require "faker"
require "database_cleaner"

include FactoryGirl::Syntax::Methods

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

nodes_on_router_1 = 8
router_1_nodes = create_list(:node, nodes_on_router_1)
router_1_tag = create(:tag, name: "72xx108")
router_1_nodes.each { |n|
  create(:link, tag: router_1_tag, node: n)
}
router_1_nodes
  .zip(nodes_on_router_1.times.map { |i| "port_#{i}" })
  .each { |node, name_tag|
    tag = create(:tag, name: name_tag)
    create(:link, tag: tag, node: node)
  }
router_1_nodes.each { |node|
  manufacturer_tag = create(:tag, name: "alcatel")
  create(:link, tag: manufacturer_tag, node: node)

  model_tag = create(:tag, name: "7750")
  create(:link, tag: model_tag, node: node)
}

nodes_on_router_2 = 10
router_2_nodes = create_list(:node, nodes_on_router_2)
router_2_tag = create(:tag, name: "55xx251")
router_2_nodes.each { |n|
  create(:link, tag: router_2_tag, node: n)
}
router_2_nodes
  .zip(nodes_on_router_2.times.map { |i| "port_#{i}" })
  .each { |node, name_tag|
    tag = create(:tag, name: name_tag)
    create(:link, tag: tag, node: node)
  }
router_2_nodes.each { |node|
  manufacturer_tag = create(:tag, name: "alcatel")
  create(:link, tag: manufacturer_tag, node: node)

  model_tag = create(:tag, name: "88900")
  create(:link, tag: model_tag, node: node)
}

nodes_in_ap_network = router_1_nodes + router_2_nodes
ap_tag = create(:tag, name: "ap_network")
nodes_in_ap_network.each { |node|
  create(:link, tag: ap_tag, node: node)
}

nodes_on_router_3 = 144
router_3_nodes = create_list(:node, nodes_on_router_3)
router_3_tag = create(:tag, name: "44uu122")
router_3_nodes.each { |n|
  create(:link, tag: router_3_tag, node: n)
}
router_3_nodes
  .zip(nodes_on_router_3.times.map { |i| "port_#{i}" })
  .each { |node, name_tag|
    tag = create(:tag, name: name_tag)
    create(:link, tag: tag, node: node)
  }
router_3_nodes.each { |node|
  manufacturer_tag = create(:tag, name: "alcatel")
  create(:link, tag: manufacturer_tag, node: node)

  model_tag = create(:tag, name: "x1400")
  create(:link, tag: model_tag, node: node)
}

nodes_on_router_4 = 17
router_4_nodes = create_list(:node, nodes_on_router_4)
router_4_tag = create(:tag, name: "973uu65")
router_4_nodes.each { |n|
  create(:link, tag: router_4_tag, node: n)
}
router_4_nodes
  .zip(nodes_on_router_4.times.map { |i| "port_#{i}" })
  .each { |node, name_tag|
    tag = create(:tag, name: name_tag)
    create(:link, tag: tag, node: node)
  }
router_4_nodes.each { |node|
  manufacturer_tag = create(:tag, name: "cisco")
  create(:link, tag: manufacturer_tag, node: node)

  model_tag = create(:tag, name: "9292")
  create(:link, tag: model_tag, node: node)
}

nodes_in_inet_network = router_3_nodes + router_4_nodes
inet_tag = create(:tag, name: "inet_network")
nodes_in_inet_network.each { |node|
  create(:link, tag: inet_tag, node: node)
}

nodes_in_internal_network = \
  nodes_in_inet_network + nodes_in_ap_network

internal_network_tag = create(
  :tag, name: "internal_network"
)
nodes_in_internal_network.each { |n|
  create(:link, tag: internal_network_tag, node: n)
}
