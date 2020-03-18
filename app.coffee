{ BigQuery } = require '@google-cloud/bigquery'
{ Octokit } = require '@octokit/rest'
_ = require 'underscore'

bigquery = new BigQuery
octokit = new Octokit
pattern = RegExp '\.csv$', 'i'

contents = octokit.repos.getContents
  owner: process.env.GITHUB_OWNER
  repo: process.env.GITHUB_REPO
  path: process.env.GITHUB_PATH

contents.then (res) ->
  filtered = _.filter res.data, (file) ->
    file.type == 'file' && pattern.test file.name
  urls = _.pluck filtered, 'download_url'
