#!/usr/bin/ruby
# expand only local includes directives like #include "local.h"
# do it recursively
# expand on stdout
DEBUG=false
STDERR.puts $LOAD_PATH.to_s if DEBUG

$pragma_once={}

# support compiler option like -I but only for local path (see https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html)
# for that we are abusing ruby $LOAD_PATH
# file are looked
# - first relative to the directory of the current file, 
# - and then in a preconfigured list of standard system directories. 
# For example, if /usr/include/sys/stat.h contains #include "types.h", 
# GCC looks for types.h first in /usr/include/sys, 
# then in its usual search path. 
def look_for_include( cwd, file)
    lookUpDir = [cwd] + $LOAD_PATH
    lookUpDir.each { |d|
        path = File.join( d, file)
        STDERR.puts "looking for #{path}"  if DEBUG
        if File.exist?( path )
            return path
        end
    }

    fail "#include not found"
end

def scan( file, indent="", last=false)
    $pragma_once[file]=true

    File.foreach( file)
        .each_with_index { |r,i| 
        # looks for  #include directive
        if r =~ /^#include\s*\"([^\"]+)/
            include_file = look_for_include( File.dirname(file), $1)
            if !$pragma_once.has_key?(include_file)
                STDERR.puts "#{indent}+- (#{i+1}) #{include_file}"
                # emit C prep code & recurse on new file
                puts "#line 1 \"#{include_file}\""
                scan( include_file, indent + ( last ? "   " : "|  "))
                puts "\n#line #{i+2} \"#{file}\""
            else
                STDERR.puts "#{indent}+- (#{i+1}) #{include_file} => already included - skipping"
            end
        else
            print r
        end 
    }
end

for arg in ARGV
    STDERR.puts arg
    scan( arg, "", true)
end
