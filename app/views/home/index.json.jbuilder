json.array! @places do |pl|
  json.extract! pl, :id, :name, :lat, :lng
end