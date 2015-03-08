require 'spec_helper'

RSpec.describe Publishable::Scopes do

  class DummyModel; end

  describe '::for' do
    context 'if model has Mongoid::Document in it\'s ancestors' do
      before(:each) do
        allow(DummyModel).to receive(:ancestors).and_return([Mongoid::Document])
      end

      it 'returns Publishable::Scopes::Mongoid' do
        scopes = Publishable::Scopes.for(DummyModel)
        expect(scopes).to eq Publishable::Scopes::Mongoid
      end
    end

    context 'if model has ActiveRecord::Base in it\'s ancestors' do
      before(:each) do
        allow(DummyModel).to receive(:ancestors).and_return([ActiveRecord::Base])
      end

      it 'returns Publishable::Scopes::ActiveRecord' do
        scopes = Publishable::Scopes.for(DummyModel)
        expect(scopes).to eq Publishable::Scopes::ActiveRecord
      end
    end

    context 'if model\'s orm is not supported or undefined' do
      it 'raises UnknownOrmError' do
        expect{
          Publishable::Scopes.for(DummyModel)
        }.to raise_error(Publishable::UnknownOrmError)
      end
    end
  end

end