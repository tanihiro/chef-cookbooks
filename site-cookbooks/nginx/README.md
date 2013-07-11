nginx Cookbook
==============
Nginx install and virtualhost setup.


e.g.
This cookbook makes your favorite breakfast sandwhich.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - nginx needs toaster to brown your bagel.

Attributes
----------

e.g.
#### nginx::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['nginx']['worker_prosesses']</tt></td>
    <td>Integer</td>
    <td>worker prosseses</td>
    <td><tt>6</tt></td>
  </tr>
  <tr>
    <td><tt>['nginx']['worker_connections']</tt></td>
    <td>Integer</td>
    <td>worker connections</td>
    <td><tt>1024</tt></td>
  </tr>
</table>

Usage
-----
#### nginx::default

e.g.
Just include `nginx` in your node's `run_list`:

```json
{
  "nginx": {
    "worker_prosesses": 12,
    "worker_connections": 2048
  },
  "run_list": [
    "recipe[nginx]"
  ]
}
```

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: itani-hiroki
