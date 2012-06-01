module ItTaxCode
  CHECK_WEIGHTS = { 
    '0' => [0,1],
    '1' => [1,0],
    '2' => [2,5],
    '3' => [3,7],
    '4' => [4,9],
    '5' => [5,13],
    '6' => [6,15],
    '7' => [7,17],
    '8' => [8,19],
    '9' => [9,21],
    'A' => [0,1],
    'B' => [1,0],
    'C' => [2,5],
    'D' => [3,7],
    'E' => [4,9],
    'F' => [5,13],
    'G' => [6,15],
    'H' => [7,17],
    'I' => [8,19],
    'J' => [9,21],
    'K' => [10,2],
    'L' => [11,4],
    'M' => [12,18],
    'N' => [13,20],
    'O' => [14,11],
    'P' => [15,3],
    'Q' => [16,6],
    'R' => [17,8],
    'S' => [18,12],
    'T' => [19,14],
    'U' => [20,16],
    'V' => [21,10],
    'W' => [22,22],
    'X' => [23,25],
    'Y' => [24,24],
    'Z' => [25,23]
  }
  LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  CHECKS = LETTERS

  def self.calculate_check_digit code
    code.upcase!
    sum = (0...15).inject 0 do |s, i|
      values = CHECK_WEIGHTS[code[i]]
      raise "invalid character" unless values
      value = values[(i+1) % 2]
      s += value
    end
    remain = sum % CHECKS.size
    CHECKS[remain]
  end

  def self.errors_for_11_digit_code code
    return ["Invalid length"] unless code.size == 11
    raise "NYI"
  end

  CODE16_LETTERS_POSITIONS = [0, 1, 2, 3, 4, 5, 8, 11]
  CODE16_LETTERS_OPTIONALS = [6, 7, 9, 10, 12, 13, 14]
  NUMBER_SUBS = "LMNPQRSTUV"

  def self.errors_for_16_digit_code code
    return ["Invalid length"] unless code.size == 16
    errors = CODE16_LETTERS_POSITIONS.collect do |pos|
      "Unexpected non letter at position #{pos + 1}" unless LETTERS.include? code[pos]
    end.compact

    optional_letter_positions = CODE16_LETTERS_OPTIONALS.collect do |pos|
      LETTERS.include? code[pos]
    end

    optional_letter_positions.each_index do |i|
      if optional_letter_positions[i]
        errors << "Invalid letter at #{CODE16_LETTERS_OPTIONALS[i] + 1}" unless NUMBER_SUBS.include? code[CODE16_LETTERS_OPTIONALS[i]]
        unless optional_letter_positions[i+1..-1].all?
          errors << "Unexpected letter at position #{CODE16_LETTERS_OPTIONALS[i] + 1}"
        end
      end
    end

    if errors.empty?
      errors << "Bad check digit (expected: #{calculate_check_digit(code)})" unless code[15] == calculate_check_digit(code)
    end
    errors
  end

  def self.errors_for code
    code.upcase!
    case code.size
    when 11 then
      errors_for_11_digit_code code
    when 16 then
      errors_for_16_digit_code code
    else
      ["code length is not valid"]
    end
  end
end

if defined?(ActiveModel)
  require 'it_tax_code_validator.rb'
end
