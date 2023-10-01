# Release process

(In all of the instructions, replace `4.x.x` with the actual new version number.)

1. Update `CHANGELOG.md`
2. Update `main.go` with new version number, e.g. `const Version = "4.x.x"`
3. If it's a major version bump (only do this for backwards incompatible changes), update the module name in `go.mod` (see: [Semantic Import Versioning](https://github.com/golang/go/wiki/Modules#semantic-import-versioning))
4. `git commit -m "Release 4.x.x"`
5. `git tag v4.x.x`
6. `git push origin head && git push origin v4.x.x`
7. `make dist` (to generate binaries)
8. Create release & upload binaries: https://github.com/schreifels/git-num/releases
9. Update `main.go` with "master" version indicator, e.g. `const Version = "master (post-4.x.x)"`
10. `git commit -m "Post-release 4.x.x"`
11. `git push origin head`
12. `make build` for your local env
13. Force an update to pkg.go.dev by running ([ref](https://pkg.go.dev/about#adding-a-package)):

```bash
GOPROXY=https://proxy.golang.org GO111MODULE=on go install github.com/schreifels/git-num/v4@v4.x.x
```
