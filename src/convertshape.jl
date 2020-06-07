function convertshape(box::ConstrainedDynamics.Box)
    x,y,z = Tuple(box.xyz)
    # return GeometryBasics.HyperRectangle(Vec(-x/2,-y/2,-z/2),Vec(x,y,z))
    return GeometryTypes.HyperRectangle(Vec(-x/2,-y/2,-z/2),Vec(x,y,z))
end

function convertshape(cylinder::ConstrainedDynamics.Cylinder)
    r,h = Tuple(cylinder.rh)
    # return GeometryBasics.Cylinder(Point(0.0,0.0,-h/2),Point(0.0,0.0,h/2), r)
    return GeometryTypes.Cylinder(Point(0.0,0.0,-h/2),Point(0.0,0.0,h/2), r)
end

function convertshape(sphere::ConstrainedDynamics.Sphere)
    r = sphere.r
    # return GeometryBasics.Sphere(Point(0.0,0.0,0.0), r)
    return GeometryTypes.Sphere(Point(0.0,0.0,0.0), r)
end

function convertshape(mesh::ConstrainedDynamics.Mesh)
    # return shape = load(mesh.path, GLUVMesh)
    return MeshCat.MeshFileGeometry(mesh.path)
end