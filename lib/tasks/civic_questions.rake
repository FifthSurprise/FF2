namespace :ff do

  task :ff_env do
    ENV["RAILS_ENV"] ||= 'development'
    require File.expand_path("../../../config/environment", __FILE__)
    Bundler.require(:default)
  end

  desc "Seed the database with US Civic questions stacks"
  task :seed_civics => [:ff_env] do
    require_relative "USCivicsQuestions.rb"


    questions = loadUSCivicsQ
    questions.shift
    civic = Stack.create(name: "US Civic Questions")
    questions.each{|q|civic.cards.create(question: q[0], answer: q[1])}

    if (User.find_by(email: "kevin.w.chang@gmail.com").nil?)
      u = User.create!({:email => "kevin.w.chang@gmail.com",
                        :password => "12345678",
                        :password_confirmation => "12345678" })
    else
      u = User.find_by(email: "kevin.w.chang@gmail.com")
    end
    civic.owner = u
    civic.save
  end

end
