# ConstrainedDynamicsVis

**ConstrainedDynamicsVis** is a visualizer for the rigid body dynamics package ConstrainedDynamics. It is built on top of MeshCat and provides an easy to use interface.

After simulating a mechanism (see ConstrainedDynamics for details), you obtain a `Storage` object. Visualization can be performed with

```julia
using ConstrainedDynamicsVis

visualize(mechanism, storage)
```

In the visualizer, the `Scene -> meshcat` tab can be used to show and hide certain bodies. And the `Animations` can be used to restart and modify the visualization. Video recording is also possible (returns a tar-file).

```@autodocs
Modules = [ConstrainedDynamicsVis]
Order   = [:function]
Pages   = ["visualize.jl"; "video.jl"]
```
