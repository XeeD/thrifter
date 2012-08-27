namespace :legacy do
  task :load_config => :environment do
    ActiveRecord::Base.configurations = Rails.application.config.database_configuration
    ActiveRecord::Migrator.migrations_paths = Rails.application.paths['db/migrate'].to_a
  end

  desc "Migrate legacy database to new system"
  task :migrate => :environment do
    migrations = [
        ProductMigrator
    ]
    migrations.map(&:new).each(&:migrate_each)
  end
end