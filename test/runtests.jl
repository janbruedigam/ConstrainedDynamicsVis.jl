using Test
using SafeTestsets


@safetestset "Preparation Test" begin
    include("setup_file.jl")
    include("preparation_test.jl")
end

@safetestset "Visualization Test" begin
    include("setup_file.jl")
    include("visualization_test.jl")
end

@safetestset "Convert Video Test" begin
    include("videoconvert_test.jl")
end
