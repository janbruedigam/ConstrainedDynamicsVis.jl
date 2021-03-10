function convertshape(box::ConstrainedDynamics.Box)
    x,y,z = Tuple(box.xyz)
    return GeometryBasics.HyperRectangle(Vec(-x/2,-y/2,-z/2),Vec(x,y,z))
end

function convertshape(cylinder::ConstrainedDynamics.Cylinder)
    r,h = Tuple(cylinder.rh)
    return GeometryBasics.Cylinder(Point(0.0,0.0,-h/2),Point(0.0,0.0,h/2), r)
end

function convertshape(sphere::ConstrainedDynamics.Sphere)
    r = sphere.r
    return GeometryBasics.Sphere(Point(0.0,0.0,0.0), r)
end

function convertshape(pyramid::ConstrainedDynamics.Pyramid)
    w, h = Tuple(pyramid.wh)
    return GeometryBasics.Pyramid(Point(0.0,0.0,-h/4), h, w)
end


function convertshape(mesh::ConstrainedDynamics.Mesh)
    # obj = MeshFileObject(mesh.path)
    # if obj.mtl_library == "" # no material file (mtl) available -> render as geometry with uniform color
    #     return MeshFileGeometry(obj.contents, obj.format)
    # end
    # return obj
    return MeshFileObject(mesh.path)
end

function convertshape(::ConstrainedDynamics.EmptyShape)
    return nothing
end