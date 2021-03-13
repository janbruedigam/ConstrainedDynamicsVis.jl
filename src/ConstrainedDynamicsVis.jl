module ConstrainedDynamicsVis

using LinearAlgebra
using StaticArrays
using ConstrainedDynamics
using ConstrainedDynamics: AbstractMechanism, Shape, vrotate, getid

using CoordinateTransformations
using GeometryBasics: GeometryBasics, Point, Vec
using Blink
using MeshCat
using MeshCat: js_scaling, js_position, js_quaternion

export visualize,
    convertvideo


include("convertshape.jl")
include("visualize.jl")

include("video.jl")

end
