require 'spec_helper'

RSpec.describe Publishable::Scopes::ActiveRecord do

  before :each do
    [:published, :planned, :expired, :draft].each do |status|
      create_list(:news, 5, status)
    end
  end

  let(:published){ News.published }
  let(:not_published){ News.not_published }
  let(:planned){ News.planned }
  let(:drafts){ News.drafts }
  let(:expired){ News.expired }

  it 'published' do
    expect( published.count ).to eq 5
    published.each do |record|
      expect( record ).to be_published
    end
  end

  it 'not_published' do
    expect( not_published.count ).to eq 15
    not_published.each do |record|
      expect( record ).not_to be_published
    end
  end

  it 'planned' do
    expect( planned.count ).to eq 5
    planned.each do |record|
      expect( record ).to be_planned
    end
  end

  it 'drafts' do
    expect( drafts.count ).to eq 5
    drafts.each do |record|
      expect( record ).to be_draft
    end
  end

  it 'expired' do
    expect( expired.count ).to eq 5
    expired.each do |record|
      expect( record ).to be_expired
    end
  end

  describe '::for?' do
    it 'returns true if model has ActiveRecord::Base in its ancestors' do
      expect(described_class).to be_for(News)
    end

    it 'returns false otherwise' do
      expect(described_class).not_to be_for(Post)
    end
  end

end