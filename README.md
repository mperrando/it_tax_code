it_tax_code
===========

An Italian tax code formal validator.

Algorithm that checks the formal validity of an Italian tax code. Due to the fact that only the Italian tax agency can release tax codes, this gem avoids the automatic calculation of a tax code, but it only checks the formal validity based on the public rules published by the Italian tax agency.

Usage
-----

Install the gem. Then in your code:

```ruby
require 'it_tax_code'

errors = ItTaxCode.errors_for "some-16-digit-italian-tax-code"
```

errors is an `Array` of `String` containing all the errors found.

ActiveModel Validator
---------------------

Also an ActiveModel validator is present.

Install the gem, if you use bundler (I hope so) add in your Gemfile

```ruby
gem 'it_tax_code', :git => 'git://github.com/mperrando/it_tax_code'
```

Then you can add the validation to your models.

```ruby
class Person
  include ActiveModel::Validations
  attr_acessor :tax_code

  validates :tax_code, :presence => true, :it_tax_code => true
end
```

TODO
----

Check formal correctness given personal data (name, surname, place of birth,
date of birth).
