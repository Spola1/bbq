server "bbqrails.ru", user: "deploy", roles: %w[app db resque_worker web]

set :resque_environment_task, true

set :workers, { "#{fetch(:application)}*" => 1 }
