# Release process

1. Update `CHANGELOG.md`
2. Update `main.go` with new version number, e.g. `const Version = "3.0.0"`
3. `git commit -m "Release 3.0.0"`
4. `git tag v3.0.0`
5. `git push origin --tags`
6. `make dist` (to generate binaries)
7. Create release & upload binaries: https://github.com/schreifels/git-num/releases
8. Update `main.go` with "master" version indicator, e.g. `const Version = "master (post-3.0.0)"`
9. `git commit -m "Post-release 3.0.0"`
10. `git push origin head`
11. `make build` for your local env
