def analyze_dir (new_dir)
    if new_dir != "."
        #original_dir = Dir::getwd
        Dir::chdir(new_dir)
    end
    total_size = 0
    paths = Dir::children(".")
    for path in paths
        if File::file?(path) == true
            path_size = File::size(path)
            scaled_size, unit = scale_change(path_size)
            puts "File #{path}, size: #{scaled_size} #{unit}";
            total_size += path_size
        elsif Dir::exist?(path) == true && File::symlink?(path) == false
            path_size = analyze_dir(path)
            scaled_size, unit = scale_change(path_size)
            puts "Directory #{path}, size: #{scaled_size} #{unit}";
            total_size += path_size
        end
    end
    if new_dir != "."
        #Dir::chdir(original_dir)
        Dir::chdir("..")
    end
    return total_size
end


def scale_change (filesize)
    digit_count=1
    unit = "bytes"
    for digits in filesize.digits
        digit_count+=1
    end
    if digit_count >= 10
        filesize = filesize / 1073741824.0
        unit = "GB"
    elsif digit_count >= 7
        filesize = filesize / 1048576.0
        unit = "MB"
    elsif digit_count >= 4
        filesize = filesize / 1024.0
        unit = "KB"
    end
    filesize = filesize.round(3)
    return filesize, unit
end

directory_size, unit = scale_change(analyze_dir("."))
puts ""
puts "Total file size in this directory: #{directory_size} #{unit}"
