Redmine::Plugin.register :basecamp_integration do
  name 'Basecamp Integration plugin'
  author 'Ben Cates & Patrick Klingemann'
  description 'Adds two way integration with Basecamp'
  version '0.0.1'
  url 'https://github.com/jackruss/redmine'
  author_url 'http://jackrussellsoftware.com'

  Issue.send(:include, BasecampIntegration::IssuePatch)
end
