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

GO ?= go
SHADOW ?= $(shell $(GO) env GOPATH)/bin/shadow


.PHONY: all build lint tidy update-codegen generate
all: build

build:
	$(GO) build ./...

lint:
	[ -f $(SHADOW) ]
	$(GO) vet -vettool=$(SHADOW) ./...

tidy:
	$(GO) mod tidy -v


update-codegen: generate tidy
generate:
	@#$(GO) mod download -x
	@$(CURDIR)/hack/update-codegen.sh


.PHONY: clean genclean
clean:
	$(GO) clean -cache -modcache -r -i

genclean:
	$(RM) -rv ./client \
		./apis/acti.cslab.ece.ntua.gr/v1alpha1/zz_generated.deepcopy.go

