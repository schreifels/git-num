module github.com/schreifels/git-num/v3

go 1.20

// Retract failed attempts at making the module visible on pkg.go.dev
retract (
	v3.0.2
	v3.0.3
	v3.0.4
)

require (
	github.com/Wing924/shellwords v1.1.0
	github.com/stretchr/testify v1.8.4
	golang.org/x/exp v0.0.0-20230801115018-d63ba01acd4b
)

require (
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)
