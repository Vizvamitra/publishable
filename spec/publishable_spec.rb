require 'spec_helper.rb'

RSpec.describe Publishable do

  describe 'validations' do
    context 'if published is true' do
      it 'validates presence of published_at' do
        expect( build(:post, published: true, published_at: Time.now) ).to be_valid
        expect( build(:post, published: false) ).to be_valid
        expect( build(:post, published: true, published_at: false) ).not_to be_valid
      end
    end
  end

  describe '#status' do
    it "returns :error if record is published but publishad_at is not set" do
      record = create(:news, :published)
      record.published_at = nil
      expect( record.status ).to eq :error
    end

    [:published, :planned, :draft, :expired].each do |state|
      it "returns :#{state} if record is #{state}" do
        expect( build(:news, state).status ).to eq state
      end
    end
  end

  describe 'predicate methodss' do
    [:published, :planned, :expired, :draft].each do |status|
      describe "##{status}?" do
        it "returns true if record is #{status}" do
          expect( build(:post, status) ).to send("be_#{status}".to_sym)
        end

        it 'returns false otherwise' do
          other_statuses = [:published, :planned, :expired, :draft] - [status]
          other_statuses.each do |other_status|
            expect( build(:post, other_status) ).not_to send("be_#{status}".to_sym)
          end
        end
      end
    end   
  end


  describe '::autoset_published_at' do

    let(:model){ Class.new(Post){autoset_published_at} }

    describe 'on published status change' do
      let(:date){ DateTime.parse("2014-02-01") }

      context 'if published was set' do
        let(:dummy){ model.create!(published: false) }

        context 'and published_at is nil' do
          it 'sets published_at to current date and time' do
            now = DateTime.now
            allow(DateTime).to receive(:now).and_return(now)
            dummy.update(published: true)
            expect( dummy.published_at ).to eq now
          end
        end

        context 'and published_at is not nil' do
          it 'preserves published_at' do
            dummy.update(published: true, published_at: date)
            expect( dummy.published_at ).to eq date
          end
        end
      end

      context 'if published was dropped' do
        let(:dummy){ model.create!(published: true) }

        it 'preserves published_at' do
          dummy.update(published: false, published_at: date)
          expect( dummy.published_at ).to eq date
        end
      end

      context 'if new record and published is set' do
        context 'and published_at is nil' do
          it 'sets published_at to current date and time' do
            now = DateTime.now
            allow(DateTime).to receive(:now).and_return(now)
            expect( model.create!(published: true).published_at ).to eq now
          end
        end

        context 'and published_at is not nil' do
          it 'preserves published_at' do
            dummy = model.create!(published: true, published_at: date)
            expect( dummy.published_at ).to eq date
          end
        end
      end

      context 'if published not changed' do
        it 'preserves published_at' do
          dummies = model.create([{published: true}, {published: false}])
          dummies.each do |dummy|
            expect{ dummy.update_attributes!(title: '123') }.not_to change{dummy.published_at}
          end
        end
      end

    end

  end

end