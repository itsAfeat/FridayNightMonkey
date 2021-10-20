extends RigidBody

onready var shipNode = get_child(0)
onready var waterNode = get_parent().get_node("Wasser")

var mdt = MeshDataTool.new()

func _ready():
	mdt.create_from_surface(waterNode.mesh, 0)
	for vtx in range(mdt.get_vertex_count()):
		var vert = mdt.get_vertex(vtx)
		print("Vertex" + str(waterNode.global_transform.xform(vert)))
