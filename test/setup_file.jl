using ConstrainedDynamics
using ConstrainedDynamicsVis
using Rotations
using MeshCat: Visualizer

box = Box(rand(4)...; color = RGBA(rand(4)...), xoff = rand(3), qoff = rand(UnitQuaternion))
cylinder = Cylinder(rand(3)...; color = RGBA(rand(4)...), xoff = rand(3), qoff = rand(UnitQuaternion))
sphere = Sphere(rand(2)...; color = RGBA(rand(4)...), xoff = rand(3), qoff = rand(UnitQuaternion))
mesh = Mesh("test_files/test.obj", rand(), rand(3,3); color = RGBA(rand(4)...), xoff = rand(3), qoff = rand(UnitQuaternion))


originbox = Origin{Float64}()
linkbox = Body(box)
nonmechbox = Body(box)
push!(box.bodyids,originbox.id)

origincylinder = Origin{Float64}()
linkcylinder = Body(cylinder)
nonmechcylinder = Body(cylinder)
push!(cylinder.bodyids,origincylinder.id)

originsphere = Origin{Float64}()
linksphere = Body(sphere)
nonmechsphere = Body(sphere)
push!(sphere.bodyids,originsphere.id)

originmesh = Origin{Float64}()
linkmesh = Body(mesh)
nonmechmesh = Body(mesh)
push!(mesh.bodyids,originmesh.id)

shapesbox = [box]
shapescylinder = [cylinder]
shapessphere = [sphere]
shapesmesh = [mesh]


mechbox = Mechanism(originbox, [linkbox], shapes = shapesbox)
mechcylinder = Mechanism(origincylinder, [linkcylinder], shapes = shapescylinder)
mechsphere = Mechanism(originsphere, [linksphere], shapes = shapessphere)
mechmesh = Mechanism(originmesh, [linkmesh], shapes = shapesmesh)

steps = Base.OneTo(10)
storagebox = simulate!(mechbox, 0.1, record = true)
storagecylinder = simulate!(mechcylinder, 0.1, record = true)
storagesphere = simulate!(mechsphere, 0.1, record = true)
storagemesh = simulate!(mechmesh, 0.1, record = true)