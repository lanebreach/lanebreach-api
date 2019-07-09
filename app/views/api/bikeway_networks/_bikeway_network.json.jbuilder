json.merge! bikeway_network.attributes.except("geom")
json.geom bikeway_network.geom.to_s