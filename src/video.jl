function convertvideo(file; pathout::String=splitdir(file)[1], filenameout::String=splitext(splitdir(file)[2])[1])
    file = abspath(file)
    pathout = abspath(pathout)
    filenameout = filenameout*".mp4"
    println("Creating " * filenameout * ".")
    MeshCat.convert_frames_to_video(file, joinpath(pathout, filenameout), overwrite=true)
    return
end