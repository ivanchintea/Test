class Profile < ApplicationRecord
  include ProfileScraper

  def self.get_from(url:)
    web_profile = ProfileScraper.get_data_from(url: url)
    @profile = Profile.new(first_name: web_profile.first_name,
                           last_name:  web_profile.last_name,
                           country: web_profile.country,
                           native_language: web_profile.native_language,
                           target_language: web_profile.target_language,
                           source: web_profile.source)
  end
end
