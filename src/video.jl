function recordvideo(;filename="video",input_path="util\\",output_path="util\\")
    # Saving MeshCat sequence as a video.
    meshcat_sequence_dir = joinpath(@__DIR__, "..", input_path)
    if filename==nothing
        filenames = readdir(meshcat_sequence_dir)
    else
        filenames = [filename * ".tar"]
    end
    for filename in filenames
        println("Converting " * filename * " to video." )
        video_dir = joinpath(@__DIR__, "..", output_path, filename[1:end-4] * ".mp4",)
        MeshCat.convert_frames_to_video(
            meshcat_sequence_dir * filename,
            video_dir,
            overwrite=true)
    end
    return
end