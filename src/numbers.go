package main

import (
	"strconv"
	"strings"
)

// Given a slice of files and a slice of patterns (numbers, ranges, or
// filenames), returns a slice of filenames.
//
// Numbers and ranges are converted to filenames using the `files` slice;
// anything that doesn't match is ignored.
//
// e.g. ["1", "explicit_file.txt", "5-7"] => ["file1", "explicit_file.txt" "file5", "file6", "file7"]
func ConvertNumbersToFiles(files []string, patterns []string) []string {
	result := []string{}

	for _, pattern := range patterns {
		resultForPattern := []string{}

		rangeParts := explodeRange(pattern)
		for _, maybeFileNumber := range rangeParts {
			if num, err := strconv.Atoi(maybeFileNumber); err != nil || num < 1 || num > len(files) {
				// Given a range like "1-5", unless there are five files provided,
				// we'll return the "1-5" as-is
				resultForPattern = []string{pattern}
				break
			} else {
				resultForPattern = append(resultForPattern, files[num-1])
			}
		}

		result = append(result, resultForPattern...)
	}

	return result
}

// Converts "1-3" => ["1", "2", "3"]
func explodeRange(maybeRange string) []string {
	rangeParts := strings.Split(maybeRange, "-")

	if len(rangeParts) == 2 {
		min, minErr := strconv.Atoi(rangeParts[0])
		max, maxErr := strconv.Atoi(rangeParts[1])

		if minErr == nil && maxErr == nil && min <= max {
			result := []string{}
			for i := min; i <= max; i++ {
				result = append(result, strconv.Itoa(i))
			}
			return result
		}
	}

	return []string{maybeRange}
}
