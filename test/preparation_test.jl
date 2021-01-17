visbox = MeshCat.Visualizer()
viscylinder = MeshCat.Visualizer()
vissphere = MeshCat.Visualizer()
vispyramid = MeshCat.Visualizer()
vismesh = MeshCat.Visualizer()

animation = MeshCat.Animation(Dict{MeshCat.SceneTrees.Path,MeshCat.AnimationClip}(), 1)

ConstrainedDynamicsVis.preparebodyvis!(storagebox, 1, linkbox.shape, animation, visbox["bundle/bodyshape"])
ConstrainedDynamicsVis.prepareoriginvis!(storagebox, originbox.shape, animation, visbox["bundle/originshape"])
@test true
ConstrainedDynamicsVis.preparebodyvis!(storagecylinder, 1, linkcylinder.shape, animation, viscylinder["bundle/bodyshape"])
ConstrainedDynamicsVis.prepareoriginvis!(storagecylinder, origincylinder.shape, animation, viscylinder["bundle/originshape"])
@test true
ConstrainedDynamicsVis.preparebodyvis!(storagesphere, 1, linksphere.shape, animation, vissphere["bundle/bodyshape"])
ConstrainedDynamicsVis.prepareoriginvis!(storagesphere, originsphere.shape, animation, vissphere["bundle/originshape"])
@test true
ConstrainedDynamicsVis.preparebodyvis!(storagepyramid, 1, linkpyramid.shape, animation, vispyramid["bundle/bodyshape"])
ConstrainedDynamicsVis.prepareoriginvis!(storagepyramid, originpyramid.shape, animation, vispyramid["bundle/originshape"])
@test true
ConstrainedDynamicsVis.preparebodyvis!(storagemesh, 1, linkmesh.shape, animation, vismesh["bundle/bodyshape"])
ConstrainedDynamicsVis.prepareoriginvis!(storagemesh, originmesh.shape, animation, vismesh["bundle/originshape"])
@test true

