#!/bin/bash
#
# Copyright contributors to the KubeAGI project
#
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
# 	  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

function debugInfo {
	df -h
	if [[ $? -eq 0 ]]; then
		exit 0
	fi
	if [[ $debug -ne 0 ]]; then
		exit 1
	fi
	exit 1
}
trap 'debugInfo $LINENO' ERR
trap 'debugInfo $LINENO' EXIT

go install sigs.k8s.io/kind@v0.22.0
kind create cluster
df -h
rerank_image="kubeagi/core-library-cli:v0.0.1-20240308-18ea8aa"
docker pull $rerank_image
kind load docker-image $rerank_image
docker rmi $rerank_image
