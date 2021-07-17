export VISUAL=nvim
export EDITOR=nvim

if command -v go &>/dev/null; then
	export PATH=$PATH:$(go env GOPATH)/bin
	export GOPATH=$(go env GOPATH)
fi
