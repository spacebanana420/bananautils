require "zlib"

def deflate_file (filename, level)
    if check_overwrite("#{filename}.cfl") == false
        return
    end
    input_file = File::read(filename)
    output_file = Zlib::Deflate.deflate(input_file, level)
    puts "#{infile} compressed"; puts "Original size: #{input_file.size}    Compressed size: #{output_file.size}"
    File.write("#{filename}.cfl", output_file)
end

def inflate_file (filename, level)
    if check_overwrite(filename_noext) == false
        return
    end
    filename_noext = remove_extension(filename, ".cfl")
    input_file = File::read(filename)
    output_file = Zlib::Inflate.inflate(input_file)
    File.write(filename_noext, output_file)
end

def print_dir ()
    paths = Dir::entries(".")
    for i in paths
        if i != "." && i != ".."
            print "#{i}   "
        end
    end
    puts ""
end

def check_overwrite (filename)
    if File::exist?(filename) == true
        puts "The file #{filename} already exists, overwrite? (y/n)"
        answer = gets.chomp
        if answer == "y" || answer == "yes"
            answer = true
        else
            answer = false
        end
    else
        answer = true
    end
    return answer
end

def remove_extension (filename, inextension)
    if inextension == nil
        start_removing = false
        extension = ""
        filename
        for i in filename.chars
            if i == "."
                start_removing = true
            end
            if start_removing == true
                extension += i
            end
        end
        filename.sub!(extension, "")
    else
        filename.sub!(inextension, "")
    end
    return filename
end

print_dir()
puts "Input file name"
filename = gets.chomp
if File::exist?(filename) == true
    deflate_file(filename, 3)
else
    puts "The specified file does not exist"
end
