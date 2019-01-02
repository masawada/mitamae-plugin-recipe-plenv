node.reverse_merge!(
  plenv: {
    scheme:     'git',
    user:       ENV['USER'],
    versions:   [],
    plenv_root: File.join(ENV['HOME'], '.plenv')
  },
)

include_recipe 'plenv::install'
