using MeshCat
using ConstrainedDynamicsVis

convertvideo("test_files/test.tar")
@test ispath("test_files/test.mp4")
rm("test_files/test.mp4")
@test true
