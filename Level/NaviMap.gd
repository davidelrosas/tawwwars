extends Polygon2D

@onready var region : RID = NavigationServer2D.region_create()

func update_navi(navmap : RID):
	NavigationServer2D.region_set_map(region,navmap)
	NavigationServer2D.region_set_transform(region,transform)
	var navpolygon : NavigationPolygon = NavigationPolygon.new()
	navpolygon.vertices = polygon
	if polygons:
		for p in polygons:
			navpolygon.add_polygon(p)
	else:
		navpolygon.add_polygon(range(polygon.size()))
	NavigationServer2D.region_set_navigation_polygon(region,navpolygon)

func _process(delta):
	pass
