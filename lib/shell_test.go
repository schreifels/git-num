package lib

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestJoinForShell(t *testing.T) {
	type Expectation = struct {
		input          []string
		expectedOutput string
	}

	expectations := []Expectation{
		{input: []string{}, expectedOutput: ""},
		{input: []string{""}, expectedOutput: "''"},
		{input: []string{"", ""}, expectedOutput: "'' ''"},
		{input: []string{"ab", "cd", "ef"}, expectedOutput: "ab cd ef"},
		{input: []string{"a b cd900", "efg"}, expectedOutput: "a\\ b\\ cd900 efg"},
		{input: []string{"/root/foo bar.txt", "baz.txt"}, expectedOutput: "/root/foo\\ bar.txt baz.txt"},
		{input: []string{"sh", "-c", "echo foo"}, expectedOutput: "sh -c echo\\ foo"},
		{input: []string{"\"foo bar\"", "baz boz"}, expectedOutput: "\"foo bar\" baz\\ boz"},
		{input: []string{"../foo/bar/baz.go"}, expectedOutput: "../foo/bar/baz.go"},
	}

	for _, expectation := range expectations {
		assert.Equal(t, expectation.expectedOutput, JoinForShell(expectation.input), "given input: "+fmt.Sprint(expectation.input))
	}
}
