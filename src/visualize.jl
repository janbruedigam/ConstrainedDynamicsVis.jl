function transform(x, q, shape)
    x_transform = Translation(x + vrotate(shape.xoffset, q))
    q_transform = LinearMap(q * shape.qoffset)

    return compose(x_transform, q_transform)
end
# function transform(x, q, shape::ConstrainedDynamics.Mesh)
#     scale_transform = LinearMap(diagm(shape.scale))
#     x_transform = Translation(x + vrotate(shape.xoffset, q))
#     q_transform = LinearMap(q * shape.qoffset)

#     return compose(x_transform, q_transform, scale_transform)
# end

function preparevis!(storage::Storage{T,N}, id, shape, animation, shapevisualizer, framevisualizer, showshape, showframes) where {T,N}
    if showshape
        for i=1:N
            shapetransform = transform(storage.x[id][i], storage.q[id][i], shape) 
            atframe(animation, i) do
                settransform!(shapevisualizer, shapetransform)
                # TODO scaling bug in MeshCat also scales orientation
                if typeof(shape) <: ConstrainedDynamics.Mesh
                    clip = MeshCat.getclip!(animation, shapevisualizer.path)
                    scale_transform = LinearMap(diagm(shape.scale))
                    MeshCat._setprop!(clip, i, "scale", "vector3", MeshCat.js_scaling(scale_transform))
                end
            end
        end
    end

    if showframes
        for i=1:N
            frametransform = compose(Translation(storage.x[id][i]),LinearMap(storage.q[id][i]))
            atframe(animation, i) do
                settransform!(framevisualizer, frametransform)
            end
        end
    end

    return
end

function MeshCat.setobject!(subvisshape, visshape, shape::Shape)
    setobject!(subvisshape, visshape, MeshPhongMaterial(color=shape.color))
end

function MeshCat.setobject!(subvisshape, visshape, shape::ConstrainedDynamics.Mesh)
    if visshape.mtl_library == ""
        visshape = MeshFileGeometry(visshape.contents, visshape.format)
        setobject!(subvisshape, visshape, MeshPhongMaterial(color=shape.color))
    else
        setobject!(subvisshape, visshape)
    end
end

"""
    visualize(mechanism, storage; env, showframes)

Visualize a `mechanism` with a trajectory stored in `storage`.

# Available kwargs
* `showframes`: Display the coordinate frames of the bodies.
* `env`:        Choose the visualization environment ("blink", "browser", "editor").
"""
function visualize(mechanism::AbstractMechanism, storage::Storage{T,N}; env::String = "blink", showframes::Bool = false) where {T,N}
    storage = deepcopy(storage) 
    bodies = mechanism.bodies
    origin = mechanism.origin
    if showframes
        triads = [Triad(0.33) for i=1:length(bodies)]
    end
    
    vis = Visualizer()
    setprop!(vis["/Background"], "top_color", RGBA(1.0, 1.0, 1.0))
    setprop!(vis["/Background"], "bottom_color", RGBA(0.5, 0.6, 0.7))
    # Somehow delete! doesn't work in a function call, so set axes to not visible for now
    setvisible!(vis["/Axes"],false)
    # delete!(vis["/Axes"])

    if env == "blink"
        open(vis, Blink.Window())
    elseif env == "browser"
        open(vis)
    elseif env == "editor"
        # Needs to be returned to show. Is there a better way of doing this?
    else
        @error "No valid visualization environment option selected."
    end

    framerate = Int64(round(1/mechanism.Δt))
    animation = Animation(Dict{MeshCat.SceneTrees.Path,MeshCat.AnimationClip}(), framerate)

    for (id,body) in enumerate(bodies)
        shape = body.shape
        visshape = convertshape(shape)
        subvisshape = nothing
        subvisframe = nothing
        showshape = false
        if visshape !== nothing
            subvisshape = vis["bodies/body:"*string(id)]
            setobject!(subvisshape,visshape,shape)
            showshape = true
        end
        if showframes
            subvisframe = vis["frames/body:"*string(id)]
            setobject!(subvisframe, triads[id])
        end
        preparevis!(storage, id, shape, animation, subvisshape, subvisframe, showshape, showframes)
    end

    id = origin.id
    shape = origin.shape
    visshape = convertshape(shape)
    if visshape !== nothing
        subvisshape = vis["bodies/origin:"*string(id)]
        setobject!(subvisshape,visshape,shape)
        shapetransform = transform(szeros(T,3), one(UnitQuaternion{T}), shape)
        # TODO scaling bug in MeshCat also scales orientation
        if typeof(visshape) <: ConstrainedDynamics.Mesh
            scale_transform = LinearMap(diagm(shape.scale))
            shapetransform = compose(transform(szeros(T,3), one(UnitQuaternion{T}), shape), scale_transform)
        else
            shapetransform = transform(szeros(T,3), one(UnitQuaternion{T}), shape)
        end
        settransform!(subvisshape, shapetransform)
    end
    if showframes
        subvisframe = vis["frames/origin:"*string(id)]
        setobject!(subvisframe, Triad(0.5))
    end

    setanimation!(vis, animation)
    env == "editor" ? (return render(vis)) : (return vis)
end

