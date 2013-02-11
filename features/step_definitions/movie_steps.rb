# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
#   create_table :movies do |t|
#     t.string :title
#     t.string :rating
#     t.text :description
#     t.datetime :release_date
#   end
  Movie.delete_all
  movies_table.hashes.each do |movie|
    Movie.create(:title => movie[:title], :release_date => movie[:release_date], :rating => movie[:rating])
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #flunk "Unimplemented"
  assert(page.body.index(e1) < page.body.index(e2))
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |isUncheck, rating_list|
  print isUncheck
  ratings = rating_list.split(",")
  ratings.each do |r|
    r.strip!
    id = "ratings_" + r
    if isUncheck == 'un' then
      uncheck(id)
    else
      check(id)
    end
  end
end

Then /I should not see movies: (.*)/ do |movieList|
  movies = movieList.split(",")
  movies.each do |m|
    title = (m.strip)[1..-2]
    i = page.body.index(title)
    assert(i == nil, "Movie " + title + " found!\nIndex: " + i.to_s + "\nPage:\n" + page.body)
  end
end

Then /I should see movies: (.*)/ do |movieList|
  movies = movieList.split(",")
  movies.each do |m|
    title = (m.strip)[1..-2]
    i = page.body.index(title)
    assert(i != nil, "Movie " + title + " NOT found!\nIndex: " + i.to_s + "\nPage:\n" + page.body)
  end
end
