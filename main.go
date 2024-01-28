package main

import (
	"bufio"
	"fmt"
	"os"

	. "github.com/schreifels/git-num/v4/lib"
)

const Version = "master (post-4.0.1)"

func PrintUsage() {
	fmt.Println(`NAME:
  git-num - Quickly reference files in Git commands using numbers

USAGE:
  git num [git_cmd [index ...] | convert [index ...] | -h | -v]

EXAMPLES:
  git num                # show 'git status' with git-num indexes
  git num add 1-3 5      # call 'git add' with files at indexes 1, 2, 3, 5
  git num diff README 2  # call 'git diff' with "README" and file at index 2
  git num reset HEAD 4   # call 'git reset HEAD' with file at index 4
  git num checkout -- 4  # call 'git checkout --' with file at index 4
  git num convert 1-3    # write filenames at indexes 1, 2, 3 to STDOUT
  git num -h             # show this help screen
  git num -v             # show version`)
}

func main() {
	// The `flag` package doesn't really handle positional arguments, and our
	// needs are very simple, so we'll parse the args ourselves
	args := os.Args[1:]

	if len(args) == 0 {
		args = []string{"status"}
	}

	command := args[0]
	commandArgs := args[1:]

	switch command {
	case "-v", "--version":
		fmt.Println("git-num version " + Version)
	case "-h", "--help":
		PrintUsage()
	case "convert":
		if len(commandArgs) > 0 {
			fmt.Print(JoinForShell(ConvertNumbersToFiles(RunAndParseStatus().Filenames, commandArgs)))
		}
	case "status":
		fmt.Print(RunAndParseStatus().AnnotatedGitStatus)
	// Debug the file regex based on the `git status` output provided to STDIN
	//   Example usage: make build && cat ~/p/git-num/lib/fixtures/git_status/renames.txt | git num debug-regex | cat -v
	case "debug-regex":
		scanner := bufio.NewScanner(os.Stdin)
		DebugStatusRegex(scanner)
	default:
		gitArgs := []string{command} // in this case, `command` is a Git command (e.g. "add")

		// For optimal performance in large repos, we'll skip fetching/parsing
		// `git status` if no numbers were passed (e.g. `git num diff`)
		if len(commandArgs) > 0 {
			gitArgs = append(gitArgs, ConvertNumbersToFiles(RunAndParseStatus().Filenames, commandArgs)...)
		}

		RunGitCommandAndExit(gitArgs)
	}
}
