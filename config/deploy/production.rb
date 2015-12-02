server '5.101.124.11', user: 'deploy', roles: %w{app db web}, primary: true

role :app, %w{deploy@5.101.124.11}
role :web, %w{deploy@5.101.124.11}
role :db,  %w{deploy@5.101.124.11}

set :rails_env, :production

set :ssh_options, {
 keys: %w(/Users/noto/.ssh/id_rsa),
 forward_agent: true,
 auth_methods: %w(publickey password),
 port: 4892
}
