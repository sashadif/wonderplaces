json.array! @places do |pl|
  json.extract! pl, :id, :name, :lat, :lng
  json.label pl.name
  json.value pl.name
  json.lat pl.lat
  json.lng pl.lng
end