require "zlib"

def deflate_file (filename, level)
    if check_overwrite("#{filename}.cfl") == false
        return
    end
    input_file = File::read(filename)
    output_file = Zlib::Deflate.deflate(input_file, level)
    puts "#{input_file} compressed"; puts "Original size: #{input_file.size}    Compressed size: #{output_file.size}"
    File.write("#{filename}.cfl", output_file)
end

def inflate_file (filename)
    filename_noext = remove_extension(filename, ".cfl")
    if check_overwrite(filename_noext) == false
        return
    end
    input_file = File::read(filename)
    output_file = Zlib::Inflate.inflate(input_file)
    File.write(filename_noext, output_file)
end

def get_compression_level ()
    numbers="0123456789"
    puts "Choose a compression level (0-9)"
    level = gets.chomp
    if numbers.include?(level) == false
        puts "You need to choose a level! Level has been defaulted to 3"
        return 3
    end
    return level.to_i
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
    puts "1. Compress    2. Decompress    3. Automatic (default)"
    puts "Choose an operation"
    operation = gets.chomp
    if "123".include?(operation) == false
        operation = 3
    else
        operation = operation.to_i
    end
    if operation == 1
        deflate_file(filename, get_compression_level())
    elsif operation == 2
        inflate_file(filename)
    else
        if filename.include?(".cfl") == false
            deflate_file(filename, get_compression_level())
        else
            inflate_file(filename)
        end
    end
else
    puts "The specified file does not exist"
end
