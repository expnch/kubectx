# kubectx
`kubectx` is a command-line utility to manage and switch between `kubectl` contexts.  This is a modification of the [original project](https://github.com/ahmetb/kubectx) that adds several features:
- Context is managed via environment variables so that terminal sessions with different contexts can be maintained.
- Any non-read-only commands run in a context specified by `$WARN_CONTEXTS` will prompt the user prior to execution (using `cowsay`).
- `kubectl` and `helm` executables are managed within contexts so that incompatible cluster versions can be used simultaneously.

Put `kubectl`, `helm`, and `kubens` in `/usr/local/bin` (or elsewhere on path).
Source `kubectx-wrapper` in `~/.bash_profile` or similar.

Environment variables that must be set:
```bash
KUBE_CONTEXT="local"
KUBECTL_EXECUTABLE="kubectl1.14"
HELM_EXECUTABLE="helm2.12.3"
WARN_CONTEXTS="aws-prod,someotherprod"
```

Dependences:
- `cowsay`
- `jq`

Expected `~/.kube` config directory structure is shown in `example/`.
