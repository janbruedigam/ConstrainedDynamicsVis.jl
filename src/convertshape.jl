function convertshape2(box::Box)
    x,y,z = Tuple(box.xyz)
    return GeometryTypes.HyperRectangle(Vec(-x/2,-y/2,-z/2),Vec(x,y,z))
end

function convertshape2(cylinder::Cylinder)
    r,h = Tuple(cylinder.rh)
    return GeometryTypes.Cylinder(Point(0.0,0.0,-h/2),Point(0.0,0.0,h/2), r)
end

function convertshape2(sphere::Sphere)
    r = sphere.r
    return GeometryTypes.Sphere(Point(0.0,0.0,0.0), r)
end

function convertshape2(mesh::Mesh)
    return shape = load(mesh.path, GLUVMesh)
end