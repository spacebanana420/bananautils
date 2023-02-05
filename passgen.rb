def passgen_ascii(passlen)
    password=""
   for i in 0..passlen
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

shell_args = ARGV
shell_args_length = shell_args.length
if shell_args_length >= 2
    if shell_args[0] == "ascii"
        mode = 1
        puts passgen_ascii(shell_args[1])
    elsif shell_args[0] == "dict"
        mode = 2
        puts passgen_dictionary(shell_args[1], shell_args[2])
    end
else
    ARGV.clear
    puts "0. Exit     1. ASCII password     2. Dictionary password"
    puts "Choose a mode"; gets mode
    numbers="012"
    if numbers.include?(mode) == false
        puts "You need to select one of the available modes!"
        return
    end
    mode = mode.to_i
    puts "Input password length"
    gets passlength
    case mode
    when 1
        puts passgen_ascii(passlength)
    when 2
        puts "Input dictionary file name"
        gets dictname
        puts passgen_dictionary(passlength, dictname)
    end
end
