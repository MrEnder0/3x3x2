from code_interpreter import nil
from toml_manager import nil
from code_parser import nil
from glyths import nil

import docopt, os, re
import std/browsers
import std/strutils
import std/terminal

when defined windows:
    const
        mainDir = r"C:\ProgramData\Grid9\"
        parserCacheDir = r"C:\ProgramData\Grid9\parser_cache\"
        logDir = r"C:\ProgramData\Grid9\logs\"
        exampleDir = r"C:\ProgramData\Grid9\examples\"
        docsDir = r"C:\ProgramData\Grid9\documentation\"
else:
    const
        mainDir = "/usr/share/Grid9/"
        parserCacheDir = "/usr/share/Grid9/parser_cache/"
        logDir = "/usr/share/Grid9/logs/"
        exampleDir = "/usr/share/Grid9/examples/"
        docsDir = "/usr/share/Grid9/documentation/"

const doc = """
Usage:
    Grid9 (about | a)
    Grid9 (version | v)
    Grid9 (documentation | d)
    Grid9 (clean | c) <folder>
    Grid9 (example | e) <name>
    Grid9 (interpret | i) <path>
    Grid9 glyth_value_get <glyth>
"""

proc about() =
    echo "\nGrid9 is a esoteric programming language that is based on a 3x3 grid of memory cells where you make patterns glyths.\nThis language created by Mr.Ender in the Nim programming language.\n"

proc version() =
    echo "\n2022-022\n"

proc clean(folder: string) =
    case folder
    of "parser_cache":
        os.removeDir(parserCacheDir)
        os.createDir(parserCacheDir)
        echo "Cleaned parser cache"
    of "logs":
        os.removeDir(logDir)
        os.createDir(logDir)
        echo "Cleaned logs"
    of "temp":
        os.removeDir(parserCacheDir)
        os.createDir(parserCacheDir)
        os.removeDir(logDir)
        os.createDir(logDir)
        echo "Cleaned all folders"
    else:
        echo "Error: Invalid folder name try any of the following 'parser_cache', 'logs', or 'temp'."

proc documentation() =
    try:
        browsers.openDefaultBrowser(docsDir & "index.html")
    except:
        echo "Error: Documentation not found, maybe you did not install the optional component."

proc example(name: string) =
    case $name
    of "example1":
        echo "\n**This example shows how to use basic language features such as the memory grid, queue and printing.**\n"
        try:
            echo readFile(exampleDir & "example1.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "example2":
        echo "\n**This example shows how to use if statements and while statements.**\n"
        try:
            echo readFile(exampleDir & "example2.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "example3":
        echo "\n**This example shows how to use the break and goto commands.**\n"
        try:
            echo readFile(exampleDir & "example3.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "give_example":
        echo "\n**This example shows how to use the give command.**\n"
        try:
            echo readFile(exampleDir & "give_example.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "random_char_example":
        echo "\n**This example shows how to use the random argument for cell modification.**\n"
        try:
            echo readFile(exampleDir & "random_char_example.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "while_nesting":
        echo "\n**This example shows how to use while loops inside of while loops.**\n"
        try:
            echo readFile(exampleDir & "while_nesting.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "if_ladder":
        echo "\n**This example shows how to use a chain of ladders to climb a if chain.**\n"
        try:
            echo readFile(exampleDir & "if_ladder.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "inf_skyscraper":
        echo "\n**This example shows how to use the inf command to make a skyscraper.**\n"
        try:
            echo readFile(exampleDir & "inf_skyscraper.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "save_load_example":
        echo "\n**This example shows how to use the save and load commands.**\n"
        try:
            echo readFile(exampleDir & "save_load_example.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "mask_example":
        echo "\n**This example shows how to use the grid mask command.**\n"
        try:
            echo readFile(exampleDir & "mask_example.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    of "xor_example":
        echo "\n**This example shows how to use the grid xor command.**\n"
        try:
            echo readFile(exampleDir & "xor_example.g9") & "\n"
        except:
            stdout.styledWriteLine(fgRed, "ERROR", fgDefault, " ", name, ".g9 not found, maybe you did not install the optional component.")
    else:
        stdout.styledWriteLine(fgYellow, "WARNING", fgDefault, " ", "No example found for your input '", name, "' try any of the following, 'example1', 'example2', 'example3', 'give_example', 'random_char_example', 'while_nesting', 'if_ladder', 'inf_skyscraper', 'save_load_example', 'mask_example', 'xor_example'.")

proc interpret*(path: string) =

    #Check if file exists and allows for file extension to not be defined
    var path = path.replace(":examples:", exampleDir)
    if os.fileExists(path):
        discard
    elif os.fileExists(path & ".g9"):
        path = path & ".g9"
    else:
        echo "\nError: File not found at '" & path & "' maybe check your path.\n"

    #Default config values
    var
        author = "unknown"
        description = "unknown"
        version = "unknown"
        showmetadata = false
        advancedParse = false
        dontCache = false
        echoGridMod = false
        noLog = false
        verbosity = 1

    #Read yaml file and overwrite default config options
    if os.fileExists(replace(path, re".g9", ".toml")):
        let
            tomlPath = replace(path, re".g9", ".toml")
            config = toml_manager.getConfig(tomlPath)
            
        author = config[1]
        description = config[2]
        version = config[3]
        showmetadata =
            if config[4] == "true":
                true
            else:
                false
        advancedParse =
            if config[0][0] == 't':
                true
            else:
                false
        dontCache =
            if config[0][1] == 't':
                true
            else:
                false
        echoGridMod =
            if config[0][2] == 't':
                true
            else:
                false
        noLog =
            if config[0][3] == 't':
                true
            else:
                false
        verbosity = parseInt(config[5])

    #Show metadata if enabled
    if showmetadata == true:
        stdout.styledWriteLine(fgGreen, "AUTHOR", fgDefault, " ", author)
        stdout.styledWriteLine(fgGreen, "DESCRIPTION", fgDefault, " ", description)
        stdout.styledWriteLine(fgGreen, "VERSION", fgDefault, " ", version)

    #Parse and interpret the code
    let parsedCode = code_parser.parse(path, advancedParse, dontCache, noLog, verbosity)
    code_interpreter.interpret(parsedCode, echoGridMod, noLog, verbosity)
    if verbosity >= 1:
        echo ""
        stdout.styledWriteLine(fgCyan, "INFO", fgDefault, " Code finished successfully!")

    let exit = readLine(stdin)
    discard exit

proc glythValueGet(glyth: string) =
    echo glyths.get_glyth(glyth)

proc main() =
    let args = docopt(doc, version = "2022-022")

    if args["about"] or args["a"]:
        about()

    if args["version"] or args["v"]:
        version()

    if args["clean"] or args["c"]:
        clean($args["<folder>"])

    if args["documentation"] or args["d"]:
        documentation()
    
    if args["example"] or args["e"]:
        example($args["<name>"])

    if args["interpret"] or args["i"]:
        interpret($args["<path>"])

    if args["glyth_value_get"]:
        glythValueGet($args["<glyth>"])

proc nonTerminal() =
    #Runs if no arguments are given
    echo "No arguments passed\n" & doc
    let exit = readLine(stdin)
    discard exit

when isMainModule:
    
    #Creates folders if they don't exist
    if not dirExists(mainDir):
        createDir(mainDir)
    if not dirExists(parserCacheDir):
        createDir(parserCacheDir)
    if not dirExists(logDir):
        createDir(logDir)

    #Checks if there are any arguments
    if len(os.commandLineParams()) > 0:
        if os.fileExists(os.commandLineParams()[0]) and len(os.commandLineParams()) == 1: interpret(os.commandLineParams()[0])
        else: main()
    else: nonTerminal()
