/*
Copyright 2024 The Kubernetes Authors.

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

variable "project_name" {
  description = "The name of the project which normally matches the repository name, e.g. cluster-api-provider-vsphere"
  type        = string
}

variable "nr_projects" {
  description = "The name of the project which normally matches the repository name, e.g. cluster-api-provider-vsphere"
  type        = number
}

variable "group" {
  description = "User or group to allow accessing the resource pools and folders"
  type        = string
}

variable "role_id" {
  description = "Role id to assign permissions"
  type        = string
}

variable "vsphere_datacenter_id" {
  description = "vSphere datacenter object id"
  type        = string
}

variable "vsphere_resource_pool_id" {
  description = "vSphere resource pool object id to create the project in"
  type        = string
}

variable "vsphere_folder_path" {
  description = "vSphere folder path to create the project in"
  type        = string
}
