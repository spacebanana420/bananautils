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

puts "Input file name"
filename = gets.chomp
if File::exist?(filename) == true
    puts "Input substring"
    subtext = gets.chomp
    print_containing_subtext(filename, subtext)
else
    puts "The file name '#{filename}' does not exist"
end
