require "zlib"

def deflate_compress (filename, level)
    input_file = File::read(filename)
    output_file = Zlib::Deflate.deflate(input_file, level)
    puts "#{infile} compressed"; puts "Original size: #{input_file.size}    Compressed size: #{output_file.size}"
    filename_noext = remove_extension(filename)
    File.write("#{filename_noext}.cfl", output_file)
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

def remove_extension (filename)
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
    return filename
end

print_dir()
puts "Input file name"
filename = gets.chomp
if File::exist? == true
    deflate_compress(filename, 3)
else
    puts "The specified file does not exist"
end
