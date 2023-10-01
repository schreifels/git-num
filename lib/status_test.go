package lib

import (
	"log"
	"os"
	"path/filepath"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
	"golang.org/x/exp/maps"
)

const (
	gitStatusDir     = "fixtures/git_status"
	gitNumStatusDir  = "fixtures/git_num_status"
	gitNumConvertDir = "fixtures/git_num_convert"
)

// Get all fixtures from dir in a map, e.g. {"basic.txt":"file contents here"}
func getFixturesByFilename(directory string) map[string]string {
	fixturesByFilename := make(map[string]string)

	files, err := os.ReadDir(directory)
	if err != nil {
		log.Fatal(err)
	}

	for _, file := range files {
		// Ignore any non-txt files, e.g. ".DS_STORE"
		if strings.HasSuffix(file.Name(), ".txt") {
			fileContents, err := os.ReadFile(filepath.Join(directory, file.Name()))
			if err != nil {
				log.Fatal(err)
			}
			fixturesByFilename[file.Name()] = string(fileContents)
		}
	}

	return fixturesByFilename
}

func TestParseStatus(t *testing.T) {
	// Example outputs from `git status`
	gitStatusOutputs := getFixturesByFilename(gitStatusDir)
	// Corresponding expected outputs from `git num status` (`git status` with annotations)
	expectedGitNumOutputs := getFixturesByFilename(gitNumStatusDir)
	// Corresponding expected outputs from `git num convert` (shell-safe filenames)
	expectedGitNumConvertOutputs := getFixturesByFilename(gitNumConvertDir)

	elementMismatchErr := "For every fixture in git_status/, there must be a corresponding expectation file in git_num_status/ and git_num_convert/ (and no extra files)"
	assert.ElementsMatch(t, maps.Keys(gitStatusOutputs), maps.Keys(expectedGitNumOutputs), elementMismatchErr)
	assert.ElementsMatch(t, maps.Keys(gitStatusOutputs), maps.Keys(expectedGitNumConvertOutputs), elementMismatchErr)

	for _, fixtureName := range maps.Keys(gitStatusOutputs) {
		t.Run(fixtureName, func(t *testing.T) {
			gitStatusOutput := gitStatusOutputs[fixtureName]
			expectedGitNumOutput := expectedGitNumOutputs[fixtureName]
			expectedGitNumConvertOutput := strings.TrimSpace(expectedGitNumConvertOutputs[fixtureName])

			actualParsedStatus := ParseStatus(gitStatusOutput)
			assert.Equal(t, expectedGitNumOutput, actualParsedStatus.AnnotatedGitStatus)
			assert.Equal(t, expectedGitNumConvertOutput, JoinForShell(actualParsedStatus.Filenames))
		})
	}
}
