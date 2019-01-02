case node[:platform]
when 'debian', 'ubuntu', 'mint'
  package 'build-essential'
when 'arch'
  package 'base-devel'
end

package 'git'
