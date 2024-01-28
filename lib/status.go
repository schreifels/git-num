package lib

import (
	"bufio"
	"fmt"
	"log"
	"regexp"
	"strings"
)

var gitStatusRegex = regexp.MustCompile(`(\t)(\x1b\[[0-9;]+m)(.+:\s+)?(.+)(\x1b\[m)`)

type ParsedStatus struct {
	// Filenames extracted from the output of `git status` (in that order)
	Filenames []string
	// `git status` with number annotations added in (includes colors)
	AnnotatedGitStatus string
}

func RunAndParseStatus() *ParsedStatus {
	return ParseStatus(GetGitStatus())
}

// Annotates the provided `git status` output with numbers
func ParseStatus(gitStatus string) *ParsedStatus {
	annotatedGitStatus := strings.Builder{}
	filenames := []string{}

	scanner := bufio.NewScanner(strings.NewReader(gitStatus))
	for scanner.Scan() {
		line := scanner.Text()
		maybeAnnotatedLine, filenamesFromLine := parseStatusLine(line, len(filenames)+1)

		annotatedGitStatus.WriteString(maybeAnnotatedLine)
		annotatedGitStatus.WriteString("\n")
		filenames = append(filenames, filenamesFromLine...)
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	return &ParsedStatus{filenames, annotatedGitStatus.String()}
}

func DebugStatusRegex(scanner *bufio.Scanner) {
	fmt.Println("")

	lineNum := 1
	for scanner.Scan() {
		line := scanner.Text()
		fmt.Printf("LINE %2d:\t%s\n", lineNum, line)
		matches := gitStatusRegex.FindStringSubmatch(line)
		for matchIdx, match := range matches {
			if matchIdx != 0 {
				fmt.Printf("\t\tMATCH %d: %s\n", matchIdx, match)
			}
		}
		lineNum++
	}

	fmt.Println("")

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}

func annotateFilenameWithNumber(filename string, number int) string {
	return fmt.Sprintf("[%d] %s", number, filename)
}

func parseStatusLine(line string, nextNumber int) (maybeAnnotatedLine string, filenames []string) {
	matches := gitStatusRegex.FindStringSubmatch(line)
	if len(matches) == 6 {
		tabMatch := matches[1]
		startColorMatch := matches[2]
		descriptionMatch := matches[3] // e.g. "new file:" or "modified:"
		filenamesMatch := matches[4]
		endColorMatch := matches[5]

		filenames = strings.Split(filenamesMatch, " -> ")
		annotatedFilenames := annotateFilenameWithNumber(filenames[0], nextNumber)
		nextNumber++

		// Handle moved files
		if len(filenames) == 2 {
			annotatedFilenames += " -> " + annotateFilenameWithNumber(filenames[1], nextNumber)
		}

		maybeAnnotatedLine = tabMatch + startColorMatch + descriptionMatch + annotatedFilenames + endColorMatch
	} else {
		// Our regex didn't find any files on this line, so return it unchanged
		maybeAnnotatedLine = line
	}

	return
}
