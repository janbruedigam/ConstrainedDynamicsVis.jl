module ConstrainedDynamicsVis

using ConstrainedDynamics

using CoordinateTransformations
using GeometryTypes: GeometryTypes, Vec, Point, GLUVMesh
using Blink
using Colors: RGBA, RGB
using FileIO, MeshIO
using MeshCat

export visualize2



include("convertshape.jl")
include("visualize.jl")

include("video.jl")

end
