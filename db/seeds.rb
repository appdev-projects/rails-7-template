# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Survey.create({
  :question => "I feel it’s okay to exaggerate the truth when it helps me avoid making someone upset.",
  :scoring_scheme => {
    "Strongly Agree" => 1,
    "Agree" => 2,
    "Neutral" => 3,
    "Disagree" => 4,
    "Strongly Disagree" => 5
  }.to_json
})

Survey.create({
  :question => "I feel comfortable admitting when I make a mistake, even if it affects my reputation.",
  :scoring_scheme => {
    "Strongly Agree" => 5,
    "Agree" => 4,
    "Neutral" => 3,
    "Disagree" => 2,
    "Strongly Disagree" => 1
  }.to_json
})

Survey.create({
  :question => "If I notice that someone is struggling emotionally, I check in with them.",
  :scoring_scheme => {
    "Strongly Agree" => 5,
    "Agree" => 4,
    "Neutral" => 3,
    "Disagree" => 2,
    "Strongly Disagree" => 1
  }.to_json
})

Survey.create({
  :question => "When making a decision that could benefit my team but hurt my reputation, I tend to stay silent to avoid the risk.",
  :scoring_scheme => {
    "Strongly Agree" => 1,
    "Agree" => 2,
    "Neutral" => 3,
    "Disagree" => 4,
    "Strongly Disagree" => 5
  }.to_json
})

Survey.create({
  :question => "When a task becomes difficult, I stick with it rather than leaving it unfinished.",
  :scoring_scheme => {
    "Strongly Agree" => 5,
    "Agree" => 4,
    "Neutral" => 3,
    "Disagree" => 2,
    "Strongly Disagree" => 1
  }.to_json
})

Survey.create({
  :question => "When others have different values or opinions, I try to understand their point of view.",
  :scoring_scheme => {
    "Strongly Agree" => 5,
    "Agree" => 4,
    "Neutral" => 3,
    "Disagree" => 2,
    "Strongly Disagree" => 1
  }.to_json
})

Survey.create({
  :question => "If I see a colleague struggling but don’t think it directly affects my work, I don’t feel compelled to offer help.",
  :scoring_scheme => {
    "Strongly Agree" => 1,
    "Agree" => 2,
    "Neutral" => 3,
    "Disagree" => 4,
    "Strongly Disagree" => 5
  }.to_json
})

Survey.create({
  :question => "I can remain calm and composed even when criticized, as long as it doesn’t affect my status or role in the organization.",
  :scoring_scheme => {
    "Strongly Agree" => 1,
    "Agree" => 2,
    "Neutral" => 3,
    "Disagree" => 4,
    "Strongly Disagree" => 5
  }.to_json
})

Survey.create({
  :question => "I avoid taking advantage of situations where others don’t notice my mistakes.",
  :scoring_scheme => {
    "Strongly Agree" => 5,
    "Agree" => 4,
    "Neutral" => 3,
    "Disagree" => 2,
    "Strongly Disagree" => 1
  }.to_json
})

Survey.create({
  :question => "When working with others, I’m comfortable asking for help if I feel overwhelmed.",
  :scoring_scheme => {
    "Strongly Agree" => 5,
    "Agree" => 4,
    "Neutral" => 3,
    "Disagree" => 2,
    "Strongly Disagree" => 1
  }.to_json
})

Survey.create({
  :question => "If someone takes credit for my work, I address it calmly instead of creating a confrontation.",
  :scoring_scheme => {
    "Strongly Agree" => 5,
    "Agree" => 4,
    "Neutral" => 3,
    "Disagree" => 2,
    "Strongly Disagree" => 1
  }.to_json
})

Survey.create({
  :question => "I rarely think about how my actions might impact others, unless it directly affects my own interests.",
  :scoring_scheme => {
    "Strongly Agree" => 1,
    "Agree" => 2,
    "Neutral" => 3,
    "Disagree" => 4,
    "Strongly Disagree" => 5
  }.to_json
})

Survey.create({
  :question => "I feel responsible to complete a task to the best of my ability when it’s assigned to me.",
  :scoring_scheme => {
    "Strongly Agree" => 5,
    "Agree" => 4,
    "Neutral" => 3,
    "Disagree" => 2,
    "Strongly Disagree" => 1
  }.to_json
})

Survey.create({
  :question => "I would rather resolve a conflict than let it build up over time.",
  :scoring_scheme => {
    "Strongly Agree" => 5,
    "Agree" => 4,
    "Neutral" => 3,
    "Disagree" => 2,
    "Strongly Disagree" => 1
  }.to_json
})

Survey.create({
  :question => "If I promise to do something, I’m usually able to follow through, but I’d consider changing the commitment if my schedule becomes too hectic.",
  :scoring_scheme => {
    "Strongly Agree" => 1,
    "Agree" => 2,
    "Neutral" => 3,
    "Disagree" => 4,
    "Strongly Disagree" => 5
  }.to_json
})
