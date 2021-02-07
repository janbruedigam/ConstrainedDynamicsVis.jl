function preparevis!(storage::Storage{T,N}, id, shape, animation, shapevisualizer, framevisualizer, showshape, showframes) where {T,N}
    if showshape
        for i=1:N
            shapecomposition = compose(Translation(storage.x[id][i] + vrotate(shape.xoffset, storage.q[id][i])),LinearMap(storage.q[id][i] * shape.qoffset))
            atframe(animation, i) do
                settransform!(shapevisualizer, shapecomposition)
            end
        end
    end

    if showframes
        for i=1:N
            framecomposition = compose(Translation(storage.x[id][i]),LinearMap(storage.q[id][i]))
            atframe(animation, i) do
                settransform!(framevisualizer, framecomposition)
            end
        end
    end

    return
end

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
            setobject!(subvisshape, visshape, MeshPhongMaterial(color=shape.color))
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
        setobject!(subvisshape, visshape, MeshPhongMaterial(color=shape.color))
        composition = compose(Translation(shape.xoffset),LinearMap(shape.qoffset))
        settransform!(subvisshape, composition)
    end
    if showframes
        subvisframe = vis["frames/origin:"*string(id)]
        setobject!(subvisframe, Triad(0.5))
    end

    setanimation!(vis, animation)
    env == "editor" ? (return render(vis)) : (return vis)
end

