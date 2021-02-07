if haskey(ENV,"RUNNER_OS") && !occursin("linux", lowercase(ENV["RUNNER_OS"]))
    ConstrainedDynamicsVis.visualize(mechbox, storagebox; showframes = true, env = "editor")
    @test true
    ConstrainedDynamicsVis.visualize(mechcylinder, storagecylinder; showframes = true, env = "editor")
    @test true
    ConstrainedDynamicsVis.visualize(mechsphere, storagesphere; showframes = true, env = "editor")
    @test true
    ConstrainedDynamicsVis.visualize(mechpyramid, storagepyramid; showframes = true, env = "editor")
    @test true
    ConstrainedDynamicsVis.visualize(mechmesh, storagemesh; showframes = true, env = "editor")
    @test true
end

ConstrainedDynamicsVis.visualize(mechbox, storagebox; showframes = true, env = "browser")
@test true
ConstrainedDynamicsVis.visualize(mechcylinder, storagecylinder; showframes = true, env = "browser")
@test true
ConstrainedDynamicsVis.visualize(mechsphere, storagesphere; showframes = true, env = "browser")
@test true
ConstrainedDynamicsVis.visualize(mechpyramid, storagepyramid; showframes = true, env = "browser")
@test true
ConstrainedDynamicsVis.visualize(mechmesh, storagemesh; showframes = true, env = "browser")
@test true