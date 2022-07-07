#!/bin/bash

# Copyright 2022 Christos Katsakioris
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

GO="$(command -v 'go')"
AWK="$(command -v 'awk')"
RSYNC="$(command -v 'rsync')"

MODULE_ROOT="$(realpath "$(dirname "${BASH_SOURCE[0]}")")/.."
MODULE_NAME="$(head -1 "$MODULE_ROOT/go.mod" | "$AWK" '{print $2}')"

CODEGEN_PKG_BASE="$("$AWK" '/k8s.io\/code-generator/ {print $1; exit}' "$MODULE_ROOT/go.mod")"
CODEGEN_VERSION="$("$AWK" '/k8s.io\/code-generator/ {print $2; exit}' "$MODULE_ROOT/go.mod")"
CODEGEN_PKG_PATH="${CODEGEN_PKG_PATH:-$("$GO" env GOPATH)/pkg/mod/${CODEGEN_PKG_BASE}@${CODEGEN_VERSION}}"

TMP_GEN_DIR="$(mktemp -d)"
cleanup() {
	rm -rf "$TMP_GEN_DIR"
}
trap "cleanup" EXIT SIGINT

OLD_SUM="$(find 'pkg' -type f -exec md5sum {} \; | sort -k 2 | md5sum | "$AWK" '{print $1}')"

bash "$CODEGEN_PKG_PATH/generate-groups.sh" \
	'all' \
	"$MODULE_NAME/pkg/client" \
	"$MODULE_NAME/pkg/apis" \
	'acti.cslab.ece.ntua.gr:v1alpha1' \
	--output-base "$TMP_GEN_DIR" \
	--go-header-file "${MODULE_ROOT}/hack/acti-boilerplate.go.txt"

"$RSYNC" -a "$TMP_GEN_DIR/$MODULE_NAME/pkg/client" "$MODULE_ROOT/pkg"
"$RSYNC" -a \
	"$TMP_GEN_DIR/$MODULE_NAME/pkg/apis/acti.cslab.ece.ntua.gr/v1alpha1/zz_generated.deepcopy.go" \
	"$MODULE_ROOT/pkg/apis/acti.cslab.ece.ntua.gr/v1alpha1/zz_generated.deepcopy.go"

NEW_SUM="$(find 'pkg' -type f -exec md5sum {} \; | sort -k 2 | md5sum | "$AWK" '{print $1}')"
[ "$OLD_SUM" == "$NEW_SUM" ] || echo -e '\n\t==>  ./pkg/client/ MODIFIED!\n'

