require 'csv'
begin
  namespace :db do
    desc "Populate the database with Units of Study"
    task :seed_uos => :environment do
      UnitOfStudy.delete_all
      csv_text = File.read(File.dirname(__FILE__) + '/seed_uos.csv')
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        alpha_code = row[0]
        title = row[1]
        UnitOfStudy.create!(title: title, alpha_code: alpha_code)
      end
    end
  end
rescue LoadError
  puts "It looks like some Gems are missing: please run bundle install"
end
