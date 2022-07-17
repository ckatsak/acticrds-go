# acticrds-go

<!--  ckatsak, Sun 17 Jul 2022 12:36:38 PM EEST  -->

[![Go Reference](https://pkg.go.dev/badge/ckatsak/acticrds-go.svg)](https://pkg.go.dev/github.com/ckatsak/acticrds-go)
[![Go Report Card](https://goreportcard.com/badge/github.com/ckatsak/acticrds-go)](https://goreportcard.com/report/github.com/ckatsak/acticrds-go)
![Go Version](https://img.shields.io/github/go-mod/go-version/ckatsak/acticrds-go)
[![GitHub License](https://img.shields.io/github/license/ckatsak/acticrds-go)](LICENSE)

To update the automatically generated code:

```console
$ hack/update-codegen.sh
Generating deepcopy funcs
Generating clientset for acti.cslab.ece.ntua.gr:v1alpha1 at github.com/ckatsak/acticrds-go/pkg/client/clientset
Generating listers for acti.cslab.ece.ntua.gr:v1alpha1 at github.com/ckatsak/acticrds-go/pkg/client/listers
Generating informers for acti.cslab.ece.ntua.gr:v1alpha1 at github.com/ckatsak/acticrds-go/pkg/client/informers
```

and possibly `go mod tidy` right after.
