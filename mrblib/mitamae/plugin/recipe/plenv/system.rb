node.reverse_merge!(
  plenv: {
    scheme:     'git',
    versions:   [],
    plenv_root: '/usr/local/plenv',
  },
)

include_recipe 'plenv::install'
