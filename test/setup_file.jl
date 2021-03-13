using ConstrainedDynamics
using ConstrainedDynamicsVis
import MeshCat

boxtemplate = Box(rand(4)...; color = RGBA(rand(4)...), xoffset = rand(3), qoffset = rand(UnitQuaternion))
cylindertemplate = Cylinder(rand(3)...; color = RGBA(rand(4)...), xoffset = rand(3), qoffset = rand(UnitQuaternion))
spheretemplate = Sphere(rand(2)...; color = RGBA(rand(4)...), xoffset = rand(3), qoffset = rand(UnitQuaternion))
pyramidtemplate = Pyramid(rand(3)...; color = RGBA(rand(4)...), xoffset = rand(3), qoffset = rand(UnitQuaternion))
meshtemplate = Mesh("test_files/test.obj", rand(), rand(3,3); color = RGBA(rand(4)...), xoffset = rand(3), qoffset = rand(UnitQuaternion), scale = ones(3)*rand())


originbox = Origin(deepcopy(boxtemplate))
linkbox = deepcopy(boxtemplate)
nonmechbox = deepcopy(boxtemplate)

origincylinder = Origin(deepcopy(cylindertemplate))
linkcylinder = deepcopy(cylindertemplate)
nonmechcylinder = deepcopy(cylindertemplate)

originsphere = Origin(deepcopy(spheretemplate))
linksphere = deepcopy(spheretemplate)
nonmechsphere = deepcopy(spheretemplate)

originpyramid = Origin(deepcopy(pyramidtemplate))
linkpyramid = deepcopy(pyramidtemplate)
nonmechpyramid = deepcopy(pyramidtemplate)

originmesh = Origin(deepcopy(meshtemplate))
linkmesh = deepcopy(meshtemplate)
nonmechmesh = deepcopy(meshtemplate)


mechbox = Mechanism(originbox, [linkbox])
mechcylinder = Mechanism(origincylinder, [linkcylinder])
mechsphere = Mechanism(originsphere, [linksphere])
mechpyramid = Mechanism(originpyramid, [linkpyramid])
mechmesh = Mechanism(originmesh, [linkmesh])

steps = Base.OneTo(10)
storagebox = simulate!(mechbox, 0.1, record = true)
storagecylinder = simulate!(mechcylinder, 0.1, record = true)
storagesphere = simulate!(mechsphere, 0.1, record = true)
storagepyramid = simulate!(mechpyramid, 0.1, record = true)
storagemesh = simulate!(mechmesh, 0.1, record = true)