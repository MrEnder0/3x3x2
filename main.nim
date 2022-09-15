from code_interpreter import nil
from code_parser import nil
from glyths import nil

import docopt, os

const doc = """
Usage:
    Grid9 (about | a)
    Grid9 (version | v)
    Grid9 (example | e) <number>
    Grid9 (clean | c) <folder>
    Grid9 (interpret | i) <path>
    Grid9 glyth_value_get <glyth>
"""

proc about() =
    echo "\nGrid9 is a esoteric programming language that is based on a 3x3 grid of memory cells where you make patterns glyths.\nThis language created by MrEnder in the Nim programming language.\n"

proc version() =
    echo "\n2022-012\n"

proc example(number: string) =
    case $number
    of "example1":
        echo "\n**This example shows how to use basic language features such as the memory grid, queue and  printing.**\n"
        try:
            echo readFile("examples/example1.g9")
        except:
            echo "Error: example1.g9 not found, maybe you did not install the optional component."
    of "example2":
        echo "\n**This example shows how to use if statements and while statements.**\n"
        try:
            echo readFile("examples/example2.g9")
        except:
            echo "Error: example2.g9 not found, maybe you did not install the optional component."
    of "example3":
        echo "\n**This example shows how to use the break and goto commands.**\n"
        try:
            echo readFile("examples/example3.g9")
        except:
            echo "Error: example3.g9 not found, maybe you did not install the optional component."
    else:
        echo "\nNo example found for your input try any of the flollowing, 'example1', 'example2', 'example3'.\n"
        
proc clean(folder: string) =
    when defined windows:
        let main_dir = r"C:\ProgramData\Grid9\"
    else:
        let main_dir = "/usr/share/Grid9/"

    case $folder
    of "parser_cache":
        if os.dirExists(main_dir):
            echo "\nCleaning parser cache folder\n"
            os.removeDir(main_dir & "parser_cache")
            os.createDir(main_dir & "parser_cache")
    of "logs":
        if os.dirExists(main_dir):
            echo "\nCleaning logs folder\n"
            os.removeDir(main_dir & "logs")
            os.createDir(main_dir & "logs")
    else:
        echo "\nFolder not found try 'parser_cache' or 'logs'.\n"

proc interpret*(path: string) =
    var parsed_code = code_parser.parse(path)
    code_interpreter.interpret(parsed_code)
    echo "\nCode finished successfully!"

    let exit = readLine(stdin)
    discard exit

proc glyth_value_get(glyth: string) =
    echo glyths.get_glyth(glyth)

proc main() =
    let args = docopt(doc, version = "2022-012")

    if args["about"] or args["a"]:
        about()

    if args["version"] or args["v"]:
        version()
    
    if args["help"] or args["h"]:
        example($args["<number>"])

    if args["clean"] or args["c"]:
        clean($args["<folder>"])

    if args["interpret"] or args["i"]:
        interpret($args["<path>"])

    if args["glyth_value_get"]:
        glyth_value_get($args["<glyth>"])

proc non_terminal() =
    echo "No arguments passed\n" & doc

    let exit = readLine(stdin)
    discard exit

when isMainModule:
    
    when defined windows:
        let main_dir = r"C:\ProgramData\Grid9\"
        let parser_cache_dir = r"C:\ProgramData\Grid9\parser_cache\"
        let log_dir = r"C:\ProgramData\Grid9\logs\"
    else:
        let main_dir = "/usr/share/Grid9/"
        let parser_cache_dir = "/usr/share/Grid9/parser_cache/"
        let log_dir = "/usr/share/Grid9/logs/"
    
    #Create the file structure for info if it doesn't exist
    if not dirExists(main_dir):
        createDir(main_dir)
        if not dirExists(parser_cache_dir):
            createDir(parser_cache_dir)
        if not dirExists(log_dir):
            createDir(log_dir)

    if len(os.commandLineParams()) > 0:
        if os.fileExists(os.commandLineParams()[0]) and len(os.commandLineParams()) == 1: interpret(os.commandLineParams()[0])
        else: main()
    else: non_terminal()
