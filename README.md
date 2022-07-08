# acticrds-go

To update the automatically generated code:

```console
$ hack/update-codegen.sh
Generating deepcopy funcs
Generating clientset for acti.cslab.ece.ntua.gr:v1alpha1 at github.com/ckatsak/acticrds-go/pkg/client/clientset
Generating listers for acti.cslab.ece.ntua.gr:v1alpha1 at github.com/ckatsak/acticrds-go/pkg/client/listers
Generating informers for acti.cslab.ece.ntua.gr:v1alpha1 at github.com/ckatsak/acticrds-go/pkg/client/informers
```

and possibly `go mod tidy` right after.
