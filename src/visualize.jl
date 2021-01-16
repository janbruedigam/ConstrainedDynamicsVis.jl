function preparebodyvis!(storage::Storage{T,N}, id, shape, animation, visualizer) where {T,N}
    for i=1:N
        storage.x[id][i] += vrotate(shape.xoffset, storage.q[id][i])
        storage.q[id][i] *= shape.qoffset

        composition = compose(Translation(storage.x[id][i]),LinearMap(storage.q[id][i]))
        atframe(animation, i) do
            settransform!(visualizer, composition)
        end
    end

    return
end

function prepareoriginvis!(::Storage{T,N}, shape, animation, visualizer) where {T,N}
    composition = compose(Translation(shape.xoffset),LinearMap(shape.qoffset))
    for i=1:N
        atframe(animation, i) do
            settransform!(visualizer, composition)
        end
    end

    return
end

function visualize(mechanism::AbstractMechanism, storage::Storage{T,N}; usebrowser::Bool = false) where {T,N}
    storage = deepcopy(storage) 
    bodies = mechanism.bodies
    origin = mechanism.origin
    
    vis = Visualizer()
    usebrowser ? open(vis) : open(vis, Blink.Window())

    framerate = Int64(round(1/mechanism.Δt))
    animation = Animation(Dict{MeshCat.SceneTrees.Path,MeshCat.AnimationClip}(), framerate)  

    for (id,body) in enumerate(bodies)
        shape = body.shape
        visshape = convertshape(shape)
        if visshape !== nothing
            subvis = vis["bundle/visshape"*string(id)]
            setobject!(subvis, visshape, MeshPhongMaterial(color=shape.color))
            preparebodyvis!(storage, id, shape, animation, subvis)
        end
    end

    id = origin.id
    shape = origin.shape
    visshape = convertshape(shape)
    if visshape !== nothing
        subvis = vis["bundle/visshape"*string(id)]
        setobject!(subvis, visshape, MeshPhongMaterial(color=shape.color))
        prepareoriginvis!(storage, shape, animation, subvis)
    end

    setanimation!(vis, animation)
    return
end

