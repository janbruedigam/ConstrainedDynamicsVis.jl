visbox = MeshCat.Visualizer()
viscylinder = MeshCat.Visualizer()
vissphere = MeshCat.Visualizer()
vispyramid = MeshCat.Visualizer()
vismesh = MeshCat.Visualizer()

animation = MeshCat.Animation(Dict{MeshCat.SceneTrees.Path,MeshCat.AnimationClip}(), 1)

ConstrainedDynamicsVis.preparevis!(storagebox, 1, linkbox.shape, animation, visbox["bundle/bodyshape"], nothing, true, false)
@test true
ConstrainedDynamicsVis.preparevis!(storagecylinder, 1, linkcylinder.shape, animation, viscylinder["bundle/bodyshape"], nothing, true, false)
@test true
ConstrainedDynamicsVis.preparevis!(storagesphere, 1, linksphere.shape, animation, vissphere["bundle/bodyshape"], nothing, true, false)
@test true
ConstrainedDynamicsVis.preparevis!(storagepyramid, 1, linkpyramid.shape, animation, vispyramid["bundle/bodyshape"], nothing, true, false)
@test true
ConstrainedDynamicsVis.preparevis!(storagemesh, 1, linkmesh.shape, animation, vismesh["bundle/bodyshape"], nothing, true, false)
@test true

