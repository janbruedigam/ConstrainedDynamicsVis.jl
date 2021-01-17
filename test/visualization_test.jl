if haskey(ENV,"RUNNER_OS") && !occursin("linux", lowercase(ENV["RUNNER_OS"]))
    ConstrainedDynamicsVis.visualize(mechbox, storagebox; usebrowser = false)
    @test true
    ConstrainedDynamicsVis.visualize(mechcylinder, storagecylinder; usebrowser = false)
    @test true
    ConstrainedDynamicsVis.visualize(mechsphere, storagesphere; usebrowser = false)
    @test true
    ConstrainedDynamicsVis.visualize(mechpyramid, storagepyramid; usebrowser = false)
    @test true
    ConstrainedDynamicsVis.visualize(mechmesh, storagemesh; usebrowser = false)
    @test true
end

ConstrainedDynamicsVis.visualize(mechbox, storagebox; usebrowser = true)
@test true
ConstrainedDynamicsVis.visualize(mechcylinder, storagecylinder; usebrowser = true)
@test true
ConstrainedDynamicsVis.visualize(mechsphere, storagesphere; usebrowser = true)
@test true
ConstrainedDynamicsVis.visualize(mechpyramid, storagepyramid; usebrowser = true)
@test true
ConstrainedDynamicsVis.visualize(mechmesh, storagemesh; usebrowser = true)
@test true