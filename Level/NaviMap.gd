class_name NaviMap

extends Polygon2D

@onready var region : RID = NavigationServer2D.region_create()

func update_navi(navmap : RID):
	NavigationServer2D.region_set_map(region,navmap)
	NavigationServer2D.region_set_transform(region,transform)
	NavigationServer2D.region_set_navigation_layers(region,1)
	var navpolygon : NavigationPolygon = NavigationPolygon.new()
	navpolygon.vertices = polygon
	if polygons:
		for p in polygons:
			navpolygon.add_polygon(p)
	else:
		navpolygon.add_polygon(range(polygon.size()))
	NavigationServer2D.region_set_navigation_polygon(region,navpolygon)
	NavigationServer2D.region_set_enabled(region,true)
	NavigationServer2D.map_force_update(navmap)
