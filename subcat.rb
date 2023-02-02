def print_containing_subtext (filename, subtext)
    linecount = 0
    file = File::open(filename,  "r")
    for line in file.readlines do
        if line.include?(subtext) == true
            puts("#{linecount}: #{line}")
            linecount+=1
        end
    end
end

shell_args = ARGV
shell_args_length = shell_args.length
puts shell_args[0]

if shell_args_length >= 1 && File::exist?(shell_args[0]) == true
    filename = shell_args[0]
else
    puts "Input file name"
    filename = gets.chomp
    if File::exist?(filename) == false
        puts "The file '#{filename}' does not exist"; return
    end
end

if shell_args_length >= 2
    subtext = shell_args[1]
else
    puts "Input substring"
    subtext = gets.chomp
end
print_containing_subtext(filename, subtext)
