require './lib/it_tax_code'

describe ItTaxCode do
  context "16 digit code" do
    describe '#calculate_check_digit' do
      context "code is PRRMRC73L24I480H" do
        context "input is PRRMRC73L24I480" do
          subject { ItTaxCode.calculate_check_digit "PRRMRC73L24I480" }
          it { should == 'H' }
        end
        context "input is PRRMRC73L24I480X" do
          subject { ItTaxCode::calculate_check_digit "PRRMRC73L24I480X" }
          it { should == 'H' }
        end
      end
      context "code is ZCCMLS37T64L654R" do
        context "input is ZCCMLS37T64L654" do
          subject { ItTaxCode.calculate_check_digit "ZCCMLS37T64L654" }
          it { should == 'R' }
        end
      end
      context "code is PVRMRT77B42A145R" do
        context "input is PVRMRT77B42A145" do
          subject { ItTaxCode.calculate_check_digit "PVRMRT77B42A145" }
          it { should == 'R' }
        end
      end
    end
    describe '#errors_for' do
      context "good codes" do
        subject { ItTaxCode.errors_for "SBLMMM72E08Z330M" }
        it { should be_empty }
      end
      context "bad check digit" do
        subject { ItTaxCode.errors_for "PRRMRC73L24I480G" }
        it { should =~ ["Bad check digit (expected: H)"] }
      end
      context "letter for number non respecting reverse order" do
        subject { ItTaxCode.errors_for "PRRMRC73L24I4L8K" }
        it { should =~ ["Unexpected letter at position 14"] }
      end
      context "invalid letter for number substitution" do
        subject { ItTaxCode.errors_for "PRRHGR45G54Q33EX" }
        it { should =~ ["Invalid letter at 15"] }
      end
      context "letter for last number" do
        subject { ItTaxCode.errors_for "PRRMRC73L24I48LK" }
        it { should be_empty }
      end
      context "number where there must be a letter" do
        subject { ItTaxCode.errors_for "PR5MRC73L24I480M" }
        it { should =~ ['Unexpected non letter at position 3'] }
      end
    end
  end
  context "11 digit code" do
  end
end
