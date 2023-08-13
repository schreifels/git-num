package main

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestConvertNumbersToFiles(t *testing.T) {
	type Expectation = struct {
		input          []string
		expectedOutput []string
	}

	assertOutput := func(t *testing.T, expectations []Expectation) {
		t.Helper()
		filesFixture := []string{"file1", "file2", "file3", "file4", "file5", "file6"}
		for _, expectation := range expectations {
			assert.Equal(t, expectation.expectedOutput, ConvertNumbersToFiles(filesFixture, expectation.input), fmt.Sprint("given input: ", expectation.input))
		}
	}

	t.Run("empty input", func(t *testing.T) {
		expectations := []Expectation{
			{input: []string{}, expectedOutput: []string{}},
			{input: []string{""}, expectedOutput: []string{""}},
		}
		assertOutput(t, expectations)
	})

	t.Run("simple replacements", func(t *testing.T) {
		expectations := []Expectation{
			{input: []string{"1", "2"}, expectedOutput: []string{"file1", "file2"}},
			{input: []string{"2", "1"}, expectedOutput: []string{"file2", "file1"}},
			{input: []string{"1", "2", "7"}, expectedOutput: []string{"file1", "file2", "7"}},
			{input: []string{"1", "2", "0"}, expectedOutput: []string{"file1", "file2", "0"}},
			{input: []string{"1", "2", "-1"}, expectedOutput: []string{"file1", "file2", "-1"}},
			{input: []string{"1", "2", "7", "999"}, expectedOutput: []string{"file1", "file2", "7", "999"}},
			{input: []string{"file1"}, expectedOutput: []string{"file1"}},
			{input: []string{"foo", "bar", "baz"}, expectedOutput: []string{"foo", "bar", "baz"}},
			{input: []string{"foo", "3", "baz"}, expectedOutput: []string{"foo", "file3", "baz"}},
			{input: []string{"foo/bar/baz1.go", "3"}, expectedOutput: []string{"foo/bar/baz1.go", "file3"}},
		}
		assertOutput(t, expectations)
	})

	t.Run("range replacements", func(t *testing.T) {
		expectations := []Expectation{
			{input: []string{"1-3"}, expectedOutput: []string{"file1", "file2", "file3"}},
			{input: []string{"2-2"}, expectedOutput: []string{"file2"}},
			{input: []string{"1", "3", "5-6"}, expectedOutput: []string{"file1", "file3", "file5", "file6"}},
			{input: []string{"foo/bar/baz1.go", "2-4", "test"}, expectedOutput: []string{"foo/bar/baz1.go", "file2", "file3", "file4", "test"}},
			{input: []string{"4-7"}, expectedOutput: []string{"4-7"}},
			{input: []string{"15-18"}, expectedOutput: []string{"15-18"}},
			{input: []string{"0-2"}, expectedOutput: []string{"0-2"}},
			{input: []string{"1--2"}, expectedOutput: []string{"1--2"}},
			{input: []string{"-1-3"}, expectedOutput: []string{"-1-3"}},
			{input: []string{"-1--3"}, expectedOutput: []string{"-1--3"}},
			{input: []string{"3-2"}, expectedOutput: []string{"3-2"}},
			{input: []string{"1-two"}, expectedOutput: []string{"1-two"}},
			{input: []string{"foo-bar"}, expectedOutput: []string{"foo-bar"}},
		}
		assertOutput(t, expectations)
	})
}
