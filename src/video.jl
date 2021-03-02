"""
    convertvideo(file; pathout, filenameout)

Convert the tar-file obtained from a simulation to an mp4-video.

# Available kwargs
* `pathout`:  The output path.
* `filename`: The new file name.
"""
function convertvideo(file; pathout::String=splitdir(file)[1], filenameout::String=splitext(splitdir(file)[2])[1])
    file = abspath(file)
    pathout = abspath(pathout)
    filenameout = filenameout*".mp4"
    println("Creating " * filenameout * ".")
    MeshCat.convert_frames_to_video(file, joinpath(pathout, filenameout), overwrite=true)
    return
end

# Fix for Windows video creation
# function convert_frames_to_video(tar_file_path::AbstractString, output_path::AbstractString="output.mp4"; framerate=60, overwrite=false)
#     output_path = abspath(output_path)
#     if !isfile(tar_file_path)
#         error("Could not find the input file $tar_file_path")
#     end
#     if isfile(output_path) && !overwrite
#         error("The output path $output_path already exists. To overwrite that file, you can pass `overwrite=true` to this function")
#     end

#     mktempdir() do tmpdir
#         run(unpack_cmd(tar_file_path, tmpdir, ".tar", nothing))
#         cmd = ["-r", string(framerate), "-i", "%07d.png", "-vcodec", "libx264", "-preset", "slow", "-pix_fmt", "yuv420p", "-crf", "18", "-filter_complex", "[0]split=2[bg][fg];[bg]drawbox=c=white@1:replace=1:t=fill[bg];[bg][fg]overlay=format=auto"]
#         if overwrite
#             push!(cmd, "-y")
#         end
#         push!(cmd, output_path)

#         cd(tmpdir) do
#             FFMPEG.exe(cmd...)
#         end
#     end
#     @info("Saved output as $output_path")
#     return output_path
# end