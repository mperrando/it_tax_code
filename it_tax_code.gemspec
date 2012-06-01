Gem::Specification.new do |s|
  s.name        = 'it_tax_code'
  s.version     = '0.0.1'
  s.date        = '2012-06-01'
  s.summary     = "Italian tax code formal validation"
  s.description = "Algorithm that checks the formal validity of an Italian tax code. Due to the fact that only the Italian
  tax agency can release tax codes, this gem avoids the automatic calculation of a tax code, but it only checks the formal validity
  based on the public rules published by the Italian tax agency."
  s.authors     = ["Marco Perrando"]
  s.email       = 'mperrando@gmail.com'
  s.files       = ["lib/it_tax_code.rb"]
  s.homepage    =
    'http://rubygems.org/gems'
end
