namespace :db do
  desc "Drop, create, migrate, seed, clone to test, run fixtures"

  task :repopulate do
    puts "Dropping database ..."
    Rake::Task['db:drop'].invoke
    puts "Recreating database ..."
    Rake::Task['db:create'].invoke
    puts "Loading schema ..."
    Rake::Task['db:schema:load'].invoke
    puts "Clonning database ..."
    Rake::Task['db:test:clone_structure'].invoke
    puts "Loading fixtures from spec ..."
    ENV['FIXTURES_PATH'] = 'spec/fixtures'
    Rake::Task['db:fixtures:load'].invoke
  end
end