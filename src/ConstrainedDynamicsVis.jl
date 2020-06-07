module ConstrainedDynamicsVis

using ConstrainedDynamics
using ConstrainedDynamics: Shape, vrotate

using Rotations
using CoordinateTransformations
using GeometryBasics: Vec, Point, GLUVMesh
using Blink
using Colors: RGBA, RGB
using FileIO, MeshIO
using MeshCat

export visualize



include("convertshape.jl")
include("visualize.jl")

include("video.jl")

end
