/*
  Copyright 2022 Christos Katsakioris

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

package v1alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// +genclient
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object

// ActiNode is a specification for an ActiNode resource.
type ActiNode struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   ActiNodeSpec   `json:"spec"`
	Status ActiNodeStatus `json:"status"`
}

// ActiNodeSpec defines the desired state of an ActiNode.
type ActiNodeSpec struct {
	// Assignments include the Pods that are executed on the Node related to an ActiNode, along
	// with the OS indices of the cores where each of them is pinned.
	Assignments map[string][]uint32 `json:"assignments"`
}

// ActiNodeStatus describes the observed state of an ActiNode.
type ActiNodeStatus struct {
	// Pinnings include the actual assignments of Pods to physical cores, as observed (and
	// enforced) by ActiK8s' `internal` controller.
	Pinnings map[string][]uint32 `json:"pinnings"`
}

// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object

// ActiNodeList is a list of ActiNode resources.
type ActiNodeList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata"`

	Items []ActiNode `json:"items"`
}
