#Create repository called fork commit history
#Create README in the repository
#Find all forks of public commits that don't have a pull request
# github.repos[index]["fork"] = true for forked repos
#Find all commit times within those forks
# date can be found at GH_APi object.commits["assignment_ruby_api_calls"][0]["commit"]["author"]["date"]
#Put those commit times into README with uniform message
#