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

    # apply scaling to geom.contents
    geom = MeshCat.MeshFileGeometry(mesh.path)
    lines = split(geom.contents, "\n")
    for (index, line) in enumerate(lines)
        if length(line) > 2 && line[1] == 'v' && line[2] == ' '
            triplet = replace(line, r"[ ]+" =>  " ")
            number_strings = split(triplet, " ")
            
            num1 = parse(Float64, number_strings[2]) * mesh.scale[1]
            num2 = parse(Float64, number_strings[3]) * mesh.scale[2]
            num3 = parse(Float64, number_strings[4]) * mesh.scale[3]
    
            lines[index] = "v $(num1) $(num2) $(num3)"
        end
    end
    new_contents = join(lines, "\n")
    return MeshFileGeometry(new_contents, "obj")
end

function convertshape(::ConstrainedDynamics.EmptyShape)
    return nothing
end