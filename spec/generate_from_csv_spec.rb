# Work in Progress

require 'rails_helper'
require 'rake'


describe 'generate_from_csv' do

  before :all do
    Etchings::Application.load_tasks
    Rake.application.rake_require 'tasks/generate_from_csv'
  end

  before do
    silence(CSVTranslator)
    # Application.load_tasks
    allow(CSV).to receive(:read) do
      [
        %&title,year,paper width (cm),paper height (cm),image width (cm),image height (cm),plates,print_run,signed,short description,long description,notes,Print,Print,Print,Print"&.split(','),
        %&"*Cats*,unmarked,57,76,24,30,,25,No,Print of a cat,"Trompe l'oeil picture frame with a kitten",,,,,&.split(','),
        %&"Self-portrait,unmarked,56,77.2,29.8,41.4,,25,Yes,Self portrait of artist's face,"The foreground of the work features a rain spotted window .","Labelled AP.",,,,&.split(',')
      ]
    end
  end

  let(:run_rake_task) { 
    Rake::Task[:generate_from_csv].reenable
    Rake.application.invoke_task "generate_from_csv[file_path]"
  }

  xit "calls write_records_to_db" do
    expect_any_instance_of(CSVTranslator).to receive(:write_records_to_db).at_least(:once)
    run_rake_task
  end

  xit "writes to the db" do
    expect(Etching).to receive(:create!).exactly(4).times
    run_rake_task
  end

end