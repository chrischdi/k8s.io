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

# Resource Pools

resource "vsphere_resource_pool" "base" {
  name                    = var.project_name
  parent_resource_pool_id = var.vsphere_resource_pool_id
}

resource "vsphere_resource_pool" "project_resource_pool" {
  count = var.nr_projects

  name                    = "${format("%03d", count.index + 1)}"
  parent_resource_pool_id = "${vsphere_resource_pool.base.id}"
}

# Folders

resource "vsphere_folder" "base" {
  path          = "${var.vsphere_folder_path}/${var.project_name}"
  type          = "vm"
  datacenter_id = var.vsphere_datacenter_id
}

resource "vsphere_folder" "project_folder" {
  count = var.nr_projects

  path          = "${vsphere_folder.base.path}/${format("%03d", count.index + 1)}"
  type          = "vm"
  datacenter_id = var.vsphere_datacenter_id
}

# Permissions

resource "vsphere_entity_permissions" "permission_resource_pool" {
  count = var.nr_projects

  entity_id = vsphere_resource_pool.project_resource_pool[count.index].id
  entity_type = "ResourcePool"
  permissions {
    user_or_group = var.group
    propagate = true
    is_group = true
    role_id = var.role_id
  }

  depends_on = [ vsphere_resource_pool.project_resource_pool ]
}

resource "vsphere_entity_permissions" "permission_folder" {
  count = var.nr_projects

  entity_id = vsphere_folder.project_folder[count.index].id
  entity_type = "Folder"
  permissions {
    user_or_group = var.group
    propagate = true
    is_group = true
    role_id = var.role_id
  }

  depends_on = [ vsphere_folder.project_folder ]
}
