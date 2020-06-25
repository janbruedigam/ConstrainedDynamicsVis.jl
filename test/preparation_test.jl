visbox = Visualizer()
viscylinder = Visualizer()
vissphere = Visualizer()
vismesh = Visualizer()

ConstrainedDynamicsVis.preparevisualize!(storagebox, shapesbox, visbox, steps, getid.(mechbox.bodies), originbox.id)
@test true
ConstrainedDynamicsVis.preparevisualize!(storagecylinder, shapescylinder, viscylinder, steps, getid.(mechcylinder.bodies), origincylinder.id)
@test true
# ConstrainedDynamicsVis.preparevisualize!(storagesphere, shapessphere, vissphere, steps, getid.(mechsphere.bodies), originsphere.id)
# @test true
ConstrainedDynamicsVis.preparevisualize!(storagemesh, shapesmesh, vismesh, steps, getid.(mechmesh.bodies), originmesh.id)
@test true

