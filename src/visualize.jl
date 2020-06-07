function visualize2(mechanism::Mechanism, storage::Storage{T,N}, shapes::Vector{<:Shape}) where {T,N}
    vis = Visualizer()
    open(vis, Blink.Window())

    storage = deepcopy(storage)
    steps = Base.OneTo(N)
    oid = mechanism.origin.id
    oshapeind = 0

    for (ind,shape) in enumerate(shapes)
        for id in shape.bodyids
            if id >= 0
                for i in steps
                    storage.x[id][i] += vrotate(shape.xoff, storage.q[id][i])
                    storage.q[id][i] *= shape.qoff
                end
                visshape = convertshape2(shape)
                setobject!(vis["bundle/visshape"*string(id)], visshape, MeshPhongMaterial(color=shape.color))
            else
                @assert id == oid
                oshapeind = ind
                visshape = convertshape2(shape)
                setobject!(vis["bundle/visshape"*string(id)], visshape, MeshPhongMaterial(color=shape.color))
            end
        end
    end

    framerate = Int64(round(1/mechanism.Δt))
    anim = MeshCat.Animation(Dict{MeshCat.SceneTrees.Path,MeshCat.AnimationClip}(), framerate)

    bodies = mechanism.bodies

    for k = steps
        MeshCat.atframe(anim, k) do
            for (id,body) in pairs(bodies)
                settransform!(vis["bundle/visshape"*string(id)], compose(Translation((storage.x[id][k])...),LinearMap(UnitQuaternion((storage.q[id][k])...))))
            end
            if oshapeind > 0
                shape = shapes[oshapeind]
                settransform!(vis["bundle/visshape"*string(oid)], compose(Translation((shape.xoff)...),LinearMap(UnitQuaternion((shape.qoff)...))))
            end
        end
    end

    MeshCat.setanimation!(vis, anim)
    return
end

