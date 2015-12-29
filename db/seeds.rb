require "factory_girl"
require "faker"
require "database_cleaner"

include FactoryGirl::Syntax::Methods

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

alcatel_tag = create(:tag, name: "alcatel")
nodes_on_router_1 = 8
router_1_nodes = create_list(:node, nodes_on_router_1)
router_1_tag = create(:tag, name: "72xx108")
router_1_ip_tag = create(:tag, name: "1.1.1.1")
router_1_nodes.each { |n|
  create(:link, tag: router_1_tag, node: n, position: 4)
  create(:link, tag: router_1_ip_tag, node: n, position: 5)
}
router_1_nodes
  .zip(nodes_on_router_1.times.map { |i| "port_#{i}" })
  .each { |node, name_tag|
    tag = create(:tag, name: name_tag)
    create(:link, tag: tag, node: node, position: 6)
  }
router_1_nodes.each { |node|
  create(:link,
    tag: alcatel_tag, node: node, position: 2
  )

  model_tag = create(:tag, name: "7750")
  create(:link, tag: model_tag, node: node, position: 3)
}

nodes_on_router_2 = 10
router_2_nodes = create_list(:node, nodes_on_router_2)
router_2_tag = create(:tag, name: "55xx251")
router_2_ip_tag = create(:tag, name: "2.2.2.2")
router_2_nodes.each { |n|
  create(:link, tag: router_2_tag, node: n, position: 4)
  create(:link, tag: router_2_ip_tag, node: n, position: 5)
}
router_2_nodes
  .zip(nodes_on_router_2.times.map { |i| "port_#{i}" })
  .each { |node, name_tag|
    tag = create(:tag, name: name_tag)
    create(:link, tag: tag, node: node, position: 6)
  }
router_2_nodes.each { |node|
  create(:link,
    tag: alcatel_tag, node: node, position: 2
  )

  model_tag = create(:tag, name: "88900")
  create(:link, tag: model_tag, node: node, position: 3)
}

nodes_in_ap_network = router_1_nodes + router_2_nodes
ap_tag = create(:tag, name: "ap_network")
nodes_in_ap_network.each { |node|
  create(:link, tag: ap_tag, node: node, position: 1)
}

nodes_on_router_3 = 144
router_3_nodes = create_list(:node, nodes_on_router_3)
router_3_tag = create(:tag, name: "44uu122")
router_3_ip_tag = create(:tag, name: "3.3.3.3")
router_3_nodes.each { |n|
  create(:link, tag: router_3_tag, node: n, position: 4)
  create(:link, tag: router_3_ip_tag, node: n, position: 5)
}
router_3_nodes
  .zip(nodes_on_router_3.times.map { |i| "port_#{i}" })
  .each { |node, name_tag|
    tag = create(:tag, name: name_tag)
    create(:link, tag: tag, node: node, position: 6)
  }
router_3_nodes.each { |node|
  create(:link,
    tag: alcatel_tag, node: node, position: 2
  )

  model_tag = create(:tag, name: "x1400")
  create(:link, tag: model_tag, node: node, position: 3)
}

nodes_on_router_4 = 17
router_4_nodes = create_list(:node, nodes_on_router_4)
router_4_tag = create(:tag, name: "973uu65")
router_4_ip_tag = create(:tag, name: "4.4.4.4")
router_4_nodes.each { |n|
  create(:link, tag: router_4_tag, node: n, position: 4)
  create(:link, tag: router_4_ip_tag, node: n, position: 5)
}
router_4_nodes
  .zip(nodes_on_router_4.times.map { |i| "port_#{i}" })
  .each { |node, name_tag|
    tag = create(:tag, name: name_tag)
    create(:link, tag: tag, node: node, position: 6)
  }

cisco_tag = create(:tag, name: "cisco")
router_4_nodes.each { |node|
  create(
    :link, tag: cisco_tag, node: node, position: 2
  )

  model_tag = create(:tag, name: "9292")
  create(:link, tag: model_tag, node: node, position: 3)
}

nodes_on_router_5 = 5
router_5_nodes = create_list(:node, nodes_on_router_5)
router_5_tag = create(:tag, name: "56li22")
router_5_ip_tag = create(:tag, name: "5.5.5.5")
router_5_nodes.each { |n|
  create(:link, tag: router_5_tag, node: n, position: 4)
  create(:link, tag: router_5_ip_tag, node: n, position: 5)
}
router_5_nodes
  .zip(nodes_on_router_5.times.map { |i| "port_#{i}" })
  .each { |node, name_tag|
    tag = create(:tag, name: name_tag)
    create(:link, tag: tag, node: node, position: 6)
  }
router_5_nodes.each { |node|
  create(
    :link, tag: cisco_tag, node: node, position: 2
  )

  model_tag = create(:tag, name: "9292")
  create(:link, tag: model_tag, node: node, position: 3)
}

nodes_in_inet_network = router_3_nodes + router_4_nodes + router_5_nodes
inet_tag = create(:tag, name: "inet_network")
nodes_in_inet_network.each { |node|
  create(:link, tag: inet_tag, node: node, position: 1)
}

nodes_in_internal_network = \
  nodes_in_inet_network + nodes_in_ap_network

internal_network_tag = create(
  :tag, name: "internal_network"
)
nodes_in_internal_network.each { |n|
  create(:link,
    tag: internal_network_tag, node: n, position: 0
  )
}
