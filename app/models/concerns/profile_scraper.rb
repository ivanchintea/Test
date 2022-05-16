module ProfileScraper
  extend ActiveSupport::Concern

  def self.get_data_from(url:)
    html = Nokogiri::HTML(URI.open(url))

    source   = url
    base_url = url.split("/").slice(0, 3).join("/")

    #Other variant how to gen profile's full_name from the profile page, no from contact tab
    #full_name = html.xpath("//strong[normalize-space()]").text

    contact_xpath = "//*[@id='contact']/div/a"
    contact_tab   = html.xpath(contact_xpath).attr('href').text

    url = base_url + contact_tab
    html = Nokogiri::HTML(URI.open(url))

    full_name = html.xpath("//*[@id='fullNameView']").text
    country   = html.xpath("//*[@id='countryView']").text
    native_l  = html.xpath("//td/div[@class='pd_bot']").text.strip.split(" ").last
    target_l  = []

    html.xpath("//*[@id='lang_full']").children().each do |language|
      if !language.text.empty?
        target_l.append(language.text.split(" to ")[0])
      end
    end

    first_name = full_name.split(" ").first
    last_name  = full_name.split(" ").last

    extracted_profile = OpenStruct.new(first_name:      first_name,
                                       last_name:       last_name,
                                       country:         country,
                                       native_language: native_l,
                                       target_language: target_l.join(", "),
                                       source:          source)

    extracted_profile
  end
end
