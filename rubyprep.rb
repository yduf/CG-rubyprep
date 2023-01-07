#!/usr/bin/ruby
# expand only local includes directives like #include "local.h"
# do it recursively
# expand on stdout
DEBUG=false
STDERR.puts $LOAD_PATH.to_s if DEBUG

$pragma_once={}

# from https://stackoverflow.com/a/16363159/51386
class String
    def black;          "\e[30m#{self}\e[0m" end
    def red;            "\e[31m#{self}\e[0m" end
    def green;          "\e[32m#{self}\e[0m" end
    def brown;          "\e[33m#{self}\e[0m" end
    def blue;           "\e[34m#{self}\e[0m" end
    def magenta;        "\e[35m#{self}\e[0m" end
    def cyan;           "\e[36m#{self}\e[0m" end
    def gray;           "\e[37m#{self}\e[0m" end
    
    def bg_black;       "\e[40m#{self}\e[0m" end
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_brown;       "\e[43m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_cyan;        "\e[46m#{self}\e[0m" end
    def bg_gray;        "\e[47m#{self}\e[0m" end
    
    def bold;           "\e[1m#{self}\e[22m" end
    def italic;         "\e[3m#{self}\e[23m" end
    def underline;      "\e[4m#{self}\e[24m" end
    def blink;          "\e[5m#{self}\e[25m" end
    def reverse_color;  "\e[7m#{self}\e[27m" end
end

# display size for human
def human( size)
    if size < 1000
        "#{size}b"
    else
        "#{size / 1000}k"
    end
end

# intercept puts, returning size of string
def s_puts( s)
    puts s
    s.size + 1      # take \n into account
end

def s_print( s)
    print s
    s.size
end

class IncludeNotFound < RuntimeError
end

# support compiler option like -I but only for local path (see https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html)
# for that we are abusing ruby $LOAD_PATH
# file are looked
# - first relative to the directory of the current file, 
# - and then in a preconfigured list of standard system directories. 
# For example, if /usr/include/sys/stat.h contains #include "types.h", 
# GCC looks for types.h first in /usr/include/sys, 
# then in its usual search path. 
def look_for_include( parent, file, line)
    cwd = File.dirname( parent)
    lookUpDir = [cwd] + $LOAD_PATH
    lookUpDir.each { |d|
        path = File.join( d, file)
        STDERR.puts "looking for #{path}"  if DEBUG
        if File.exist?( path )
            return path
        end
    }

    fail IncludeNotFound, "#{parent}:#{line+1} #include \"#{file}\" not found"
end

def scan( file, indent="", last=false)
    $pragma_once[file]=true
    size = 0

    File.foreach( file)
        .each_with_index { |r,i| 
        # looks for  #include directive
        if r =~ /^#include\s*\"([^\"]+)/
            include_file = look_for_include( file, $1, i)
            include_file_ref = "+- #{i+1}: #{include_file} (#{human( File.size(include_file))})"

            if !$pragma_once.has_key?(include_file)
                STDERR.puts "#{indent}#{include_file_ref}".blue.bold
                # emit C prep code & recurse on new file
                size += s_puts "# #{1} \"#{include_file}\""
                size += scan( include_file, indent + ( last ? "   " : "|  "))
                size += s_puts "\n# #{i+2} \"#{file}\""
            else
                STDERR.puts "#{indent}".blue.bold + "#{include_file_ref} => already included - skipping".gray
                size += s_puts ""    # skipped #include still have to fill blank to have correct line count
            end
        elsif r =~ /^#pragma\s+once/
            size += s_print "//"  # comment #pragma once, to avoid warning in results and keep line count
            size += s_print r
        else
            size += s_print r.to_s
        end 
    }

    size
end

begin
    total_size = 0
    for arg in ARGV
        STDERR.puts arg.green.bold
        file_size = scan( arg, "", true)
        STDERR.puts "-> #{arg} (#{human(file_size)})".green.bold
        total_size += file_size
    end

    if total_size < 100*1000
        STDERR.puts "Total (#{human(total_size)})".green.bold
    else
        STDERR.puts "Total (#{human(total_size)})".red.bold
    end
rescue IncludeNotFound => detail
    STDERR.puts detail.to_s.red.bold
end
