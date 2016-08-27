# -*- coding: utf-8 -*-

module Plugin::RSS
  class Site < Retriever::Model
    self.keys = [[:name, :string, true],
                 [:description, :string],
                 [:link, :string],
                 [:created, :time],
                 [:profile_image_url, :string],
                 [:feed_url, :string]
                ]

    def idname
      link
    end

    def perma_link
      link
    end

    def modified
      created
    end

    def user
      self
    end

    def profile_image_url_large
      profile_image_url
    end

    def verified?
      false
    end

    def protected?
      false
    end
  end

  class Item < Retriever::Model
    include Retriever::Model::MessageMixin

    register :rss, name: "RSS Topic"

    self.keys = [[:guid, :string],
                 [:link, :string],
                 [:title, :string, true],
                 [:description, :string],
                 [:created, :time],
                 [:site, Plugin::RSS::Site, true],
                ]

    def to_show
      @to_show ||= self[:title].gsub(/&(gt|lt|quot|amp);/){|m| {'gt' => '>', 'lt' => '<', 'quot' => '"', 'amp' => '&'}[$1] }.freeze
    end

    def user
      site
    end

    def perma_link
      link
    end

  end
end
