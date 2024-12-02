require "faker"

desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do

  # Destroying Previous Data
  pp "Destroying Previous Data"

  if Rails.env.development?
    User.destroy_all
    Message.destroy_all
    Survey.destroy_all
    SurveyResponse.destroy_all
  end

  # Generate Users
  pp "Generating Users"

  CSV.foreach("lib/sample_data/user.csv", :headers => true) do |row|
    user = User.new
    user.id = row[0]
    user.email = row[1]
    user.password = row[2]
    user.username = row[3]
    user.first_name = row[4]
    user.last_name = row[5]
    user.avatar = row[6]
    user.bio = row[7]
    user.video_url = row[8]
    user.age = row[9]
    user.gender = row[10]
    user.occupation = row[11]
    user.survey_score = row[12]
    user.facebook_url = row[13]
    user.instagram_url = row[14]
    user.location = row[15]
    user.budget = row[16]

    user.save
  end

  pp "There are now #{User.count} users."

  ##Generate Messages
  pp "Generate Messages"

  CSV.foreach("lib/sample_data/message.csv", :headers => true) do |row|
    message = Message.new
    message.id = row[0]
    message.created_at = row[1]
    message.body = row[3]
    message.sender_id = row[4]
    message.recipient_id = row[5]

    message.save
  end

  pp "There are now #{Message.count} messages."

  ##Generate Survey
  pp "Generate Surveys"

  CSV.foreach("lib/sample_data/survey.csv", :headers => true) do |row|
    survey = Survey.new
    survey.id = row[0]
    survey.question = row[1]
    survey.scoring_scheme = row[2]

    survey.save
  end

  pp "There are now #{Survey.count} surveys."

  ##Generate Survey Responses
  pp "Generate Survey Responses"

  CSV.foreach("lib/sample_data/survey_response.csv", :headers => true) do |row|
    survey_response = SurveyResponse.new
    survey_response.id = row[0]
    survey_response.user_id = row[1]
    survey_response.survey_id = row[2]
    survey_response.score = row[3]

    survey_response.save
  end

  pp "There are now #{SurveyResponse.count} survey responses."
end
