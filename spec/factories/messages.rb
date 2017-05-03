# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :message do
    sequence(:content) { |n| "content #{ n } " }
  end
end

