if haskey(ENV,"RUNNER_OS") && !occursin("linux", lowercase(ENV["RUNNER_OS"]))
    ConstrainedDynamicsVis.visualize(mechbox, storagebox, shapesbox; usebrowser = false)
    @test true
    ConstrainedDynamicsVis.visualize(mechcylinder, storagecylinder, shapescylinder; usebrowser = false)
    @test true
    # ConstrainedDynamicsVis.visualize(mechsphere, storagesphere, shapessphere; usebrowser = false)
    # @test true
    ConstrainedDynamicsVis.visualize(mechmesh, storagemesh, shapesmesh; usebrowser = false)
    @test true
end

ConstrainedDynamicsVis.visualize(mechbox, storagebox, shapesbox; usebrowser = true)
@test true
ConstrainedDynamicsVis.visualize(mechcylinder, storagecylinder, shapescylinder; usebrowser = true)
@test true
# ConstrainedDynamicsVis.visualize(mechsphere, storagesphere, shapessphere; usebrowser = true)
# @test true
ConstrainedDynamicsVis.visualize(mechmesh, storagemesh, shapesmesh; usebrowser = true)
@test true