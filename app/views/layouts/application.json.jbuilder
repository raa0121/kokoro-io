json.results do |json|
  json.data JSON.parse(yield)
end
