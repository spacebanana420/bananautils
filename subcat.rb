def print_containing_subtext (filename, subtext)
    linecount = 1
    anyfound = 0
    file = File::open(filename,  "r")
    for line in file.readlines do
        if line.include?(subtext) == true
            puts("#{linecount}: #{line}")
            anyfound+=1
        end
        linecount+=1
    end
    if anyfound == 0
        puts "No lines containing the substring '#{subtext}' have been found"
    end
end

shell_args = ARGV
shell_args_length = shell_args.length

if shell_args_length >= 2 && File::exist?(shell_args[0]) == true
    filename = shell_args[0]
    subtext = shell_args[1]
else
    ARGV.clear
    puts "Input file name"
    filename = gets.chomp
    if File::exist?(filename) == false
        puts "The file '#{filename}' does not exist"; return
    end
    puts "Input substring"
    subtext = gets.chomp
end
print_containing_subtext(filename, subtext)
