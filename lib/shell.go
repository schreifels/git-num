package lib

import (
	"fmt"
	"os"
	"os/exec"
	"strings"

	"github.com/Wing924/shellwords"
)

func GetGitStatus() string {
	cmd := exec.Command("git", "-c", "color.status=always", "-c", "status.short=false", "status")
	output, err := cmd.CombinedOutput()

	if err != nil {
		fmt.Fprintln(os.Stderr, string(output))
		os.Exit(1)
	}

	return string(output)
}

func RunGitCommandAndExit(args []string) {
	cmd := exec.Command("git", args...)

	// We need to connect STDIN for commands like `git add --patch`
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	cmd.Run()
	os.Exit(cmd.ProcessState.ExitCode())
}

// Escapes args for a shell cmd (e.g. ["a", "b c"] => "a b\ c")
func JoinForShell(words []string) string {
	escapedWords := []string{}

	for _, word := range words {
		// Sometimes Git quotes filenames for us
		if strings.HasPrefix(word, "\"") && strings.HasSuffix(word, "\"") {
			escapedWords = append(escapedWords, word)
		} else {
			escapedWords = append(escapedWords, shellwords.Escape(word))
		}
	}

	return strings.Join(escapedWords, " ")
}
