def passgen_ascii(passlen)
    password=""
   for i in 0..passlen-1
        randomgen = Random.new
        character = randomgen.rand(33..127).chr
        password += character
   end
   return password
end

def passgen_dictionary(passlen, dictionaryname)
    if File::exist?(dictionaryname) == false
        puts "The dictionary '#{dictionaryname}' does not exist!"
        return
    end

    password=""
    dictionary = File::open(dictionaryname)
    lines = dictionary.readlines
    lines_amt = lines.length
    chosen_keywords = Array.new(passlen)

    for i in 0..passlen-1
        randomgen = Random.new
        chosen_keywords[i] = lines[randomgen.rand(0..lines_amt-1)].chop
    end

    for i in chosen_keywords
        password = password + i + " "
    end
    return password
end

def calculate_entropy (length)
    entropy = 94**length
    entropy = Math.log(entropy,2)
    return entropy
end

def save_file (password)
    if File::exist?("password.txt") == true
        puts "The file 'password.txt' already exists, overwrite? (y/n)"
        answer = gets.chomp
        if answer != "y" && answer != "yes"
            return
        end
    end
    File::write("password.txt", password)
end

dictname = ""
shell_args = ARGV
shell_args_length = shell_args.length
if shell_args_length >= 2
    if shell_args[0] == "ascii"
        mode = 1
    elsif shell_args[0] == "dict"
        mode = 2
        dictname = shell_args[2]
    end
    passlength = shell_args[1]
    ARGV.clear
else
    ARGV.clear
    puts "0. Exit     1. ASCII password     2. Dictionary password"
    puts "Choose a mode"; mode = gets.chomp
    numbers="012"
    if numbers.include?(mode) == false
        puts "You need to select one of the available modes!"
        return
    end
    mode = mode.to_i
    puts "Input password length"
    passlength = gets.chomp
    passlength = passlength.to_i
end

case mode
when 1
    password = passgen_ascii(passlength)
    puts "Password: #{password}"
when 2
    if dictname == ""
        puts "Input dictionary file name"
        dictname = gets.chomp
    end
    password = passgen_dictionary(passlength, dictname)
    puts "Password: #{password}"
end
puts "Entropy: #{calculate_entropy(passlength)} bits"
puts ""; puts "Save password to file? (y/n)"
saveanswer = gets.chomp
if saveanswer == "y" || saveanswer == "yes"
    save_file(password)
end
