# Release process

1. Update `CHANGELOG.md`
2. Update `main.go` with new version number, e.g. `const Version = "3.0.0"`
3. If it's a major version bump (only do this for backwards incompatible changes), update the module name in `go.mod` (see: [Semantic Import Versioning](https://github.com/golang/go/wiki/Modules#semantic-import-versioning))
4. `git commit -m "Release 3.0.0"`
5. `git tag v3.0.0`
6. `git push origin v3.0.0`
7. `make dist` (to generate binaries)
8. Create release & upload binaries: https://github.com/schreifels/git-num/releases
9. Update `main.go` with "master" version indicator, e.g. `const Version = "master (post-3.0.0)"`
10. `git commit -m "Post-release 3.0.0"`
11. `git push origin head`
12. `make build` for your local env
13. Force an update to pkg.go.dev by running ([ref](https://pkg.go.dev/about#adding-a-package)):

```bash
GOPROXY=https://proxy.golang.org GO111MODULE=on go get github.com/schreifels/git-num/v3@v3.0.0
```
