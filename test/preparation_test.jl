using ConstrainedDynamics
using Rotations


box = Box(rand(4)...; color = RGBA(rand(3)...), xoff = rand(3), qoff = Quaternion(rand(RotMatrix{3})))
cylinder = Cylinder(rand(3)...; color = RGBA(rand(3)...), xoff = rand(3), qoff = Quaternion(rand(RotMatrix{3})))
sphere = Sphere(rand(2)...; color = RGBA(rand(3)...), xoff = rand(3), qoff = Quaternion(rand(RotMatrix{3})))
mesh = ("test.obj", rand(), rand(3,3); color = RGBA(rand(3)...), xoff = rand(3), qoff = Quaternion(rand(RotMatrix{3})))


originbox = Origin{Float64}()
linkbox = Body(box)
push!(box.bodyids,originbox.id)

origincylinder = Origin{Float64}()
linkcylinder = Body(cylinder)
push!(cylinder.bodyids,origincylinder.id)

originsphere = Origin{Float64}()
linksphere = Body(sphere)
push!(sphere.bodyids,originsphere.id)

originmesh = Origin{Float64}()
linkmesh = Body(mesh)
push!(mesh.bodyids,originmesh.id)

shapesbox = [box]
shapescylinder = [cylinder]
shapessphere = [sphere]
shapesmesh = [mesh]


mechbox = Mechanism(originbox, [linkbox], shapes = shapesbox)
mechcylinder = Mechanism(origincylinder, [linkcylinder], shapes = shapescylinder)
mechsphere = Mechanism(originsphere, [linksphere], shapes = shapessphere)
mechbox = Mechanism(originbox, [linkbox], shapes = shapesbox)

steps = Base.OneTo(10)
storagebox = simulate!(mechbox, 0.1, record = true)
storagecylinder = simulate!(mechcylinder, 0.1, record = true)
storagesphere = simulate!(mechsphere, 0.1, record = true)
storagemesh = simulate!(mechmesh, 0.1, record = true)

visbox = Visualizer()
viscylinder = Visualizer()
vissphere = Visualizer()
vismesh = Visualizer()

preparevisualize!(storagebox, shapesbox, visbox, steps, originbox.id)
@test true
preparevisualize!(storagecylinder, shapescylinder, viscylinder, steps, origincylinder.id)
@test true
preparevisualize!(storagesphere, shapessphere, vissphere, steps, originsphere.id)
@test true
preparevisualize!(storagemesh, shapesmesh, vismesh, steps, originmesh.id)
@test true

