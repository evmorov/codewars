require 'webmock/cucumber'

CODEWARS_BASE = 'https://www.codewars.com'
CODEWARS_API = '/api/v1'

Before('@stub_attempt_solution') do
  project_id = '562cbb369116fb896c00002a'
  solution_id = '562cbb379116fb896c00002c'
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_post("/code-challenges/projects/#{project_id}/solutions/#{solution_id}/attempt")
    .with(
      body: { code: 'solved_kata' },
      headers: { Authorization: api_key }
    ).to_return(json_response 'attempt_solution.json')
end

Before('@stub_deferred_response') do
  dmid = '4rsdaDf8d'
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_get("/deferred/#{dmid}")
    .with(headers: { Authorization: api_key })
    .to_return(json_response 'deferred_response.json')
end

Before('@stub_deferred_response_invalid') do
  dmid = '4rsdaDf8d'
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_get("/deferred/#{dmid}")
    .with(headers: { Authorization: api_key })
    .to_return(json_response 'deferred_response_invalid.json')
end

Before('@stub_deferred_response_progress') do
  dmid = '4rsdaDf8d'
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_get("/deferred/#{dmid}")
    .with(headers: { Authorization: api_key })
    .to_return(json_response 'deferred_response_progress.json')
end

Before('@stub_finalize_solution') do
  project_id = '562cbb369116fb896c00002a'
  solution_id = '562cbb379116fb896c00002c'
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_post("/code-challenges/projects/#{project_id}/solutions/#{solution_id}/finalize")
    .with(headers: { Authorization: api_key })
    .to_return(json_response 'finalize_solution.json')
end

Before('@stub_train_next_kata_peek') do
  language = 'java'
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_post("/code-challenges/#{language}/train")
    .with(
      body: { peek: 'true', strategy: 'default' },
      headers: { Authorization: api_key }
    ).to_return(json_response 'train_next_kata_peek.json')
end

Before('@stub_train_next_kata_peek_unauthorized') do
  language = 'java'
  stub_post("/code-challenges/#{language}/train")
    .with(
      body: { peek: 'true', strategy: 'default' },
      headers: { Authorization: 'wrong_key' }
    ).to_return(json_response 'unauthorized.json')
end

Before('@stub_train_specific_kata') do
  language = 'java'
  id_or_slug = 'anything-to-integer'
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_post("/code-challenges/#{id_or_slug}/#{language}/train")
    .with(headers: { Authorization: api_key })
    .to_return(json_response 'train_specific_kata.json')
end

Before('@stub_train_specific_kata_ruby') do
  language = 'ruby'
  id_or_slug = 'anything-to-integer'
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_post("/code-challenges/#{id_or_slug}/#{language}/train")
    .with(headers: { Authorization: api_key })
    .to_return(json_response 'train_specific_kata.json')
end

def stub_get(url)
  stub_request(:get, "#{CODEWARS_BASE}#{CODEWARS_API}#{url}")
end

def stub_post(url)
  stub_request(:post, "#{CODEWARS_BASE}#{CODEWARS_API}#{url}")
end

def json_response(file)
  {
    body: fixture(file),
    headers: { content_type: 'application/json; charset=utf-8' }
  }
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def fixture_path
  File.expand_path('../../fixtures', __FILE__)
end
