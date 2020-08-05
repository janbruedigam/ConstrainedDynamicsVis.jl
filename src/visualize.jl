function preparevisualize!(storage, shapes, visualizer, steps, bodyids, originid)
    oshapeind = 0
    for (ind,shape) in enumerate(shapes)
        for id in shape.bodyids
            if id ∈ bodyids
                for i in steps
                    storage.x[id][i] += vrotate(shape.xoffset, storage.q[id][i])
                    storage.q[id][i] *= shape.qoffset
                end
            elseif id == originid
                oshapeind = ind
            else
                continue
            end
            visshape = convertshape(shape)
            setobject!(visualizer["bundle/visshape"*string(id)], visshape, MeshPhongMaterial(color=shape.color))
        end
    end

    return oshapeind
end

function visualize(mechanism::AbstractMechanism, storage::Storage{T,N}, shapes::Vector{<:Shape}; usebrowser::Bool = false) where {T,N}
    vis = Visualizer()
    usebrowser ? open(vis) : open(vis, Blink.Window())

    storage = deepcopy(storage)
    steps = Base.OneTo(N)
    bodies = mechanism.bodies
    oid = mechanism.origin.id
    
    oshapeind = preparevisualize!(storage, shapes, vis, steps, getid.(bodies), oid)

    framerate = Int64(round(1/mechanism.Δt))
    animation = Animation(Dict{MeshCat.SceneTrees.Path,MeshCat.AnimationClip}(), framerate)  

    for k = steps
        atframe(animation, k) do
            for (id,body) in pairs(bodies)
                settransform!(vis["bundle/visshape"*string(id)], compose(Translation((storage.x[id][k])...),LinearMap(UnitQuaternion((storage.q[id][k])...))))
            end
            if oshapeind > 0
                shape = shapes[oshapeind]
                settransform!(vis["bundle/visshape"*string(oid)], compose(Translation((shape.xoffset)...),LinearMap(UnitQuaternion((shape.qoffset)...))))
            end
        end
    end

    setanimation!(vis, animation)
    return
end

