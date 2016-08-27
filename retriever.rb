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
    register :rss, name: "RSS Topic"
    self.keys = [[:guid, :string],
                 [:link, :string],
                 [:title, :string, true],
                 [:description, :string],
                 [:created, :time],
                 [:site, Plugin::RSS::Site, true],
                ]
    def links
      []
    end
    alias :entity :links

    def mentioned_by_me?
      false
    end

    def favorite(_)
      # Intentionally blank
    end

    def favorite?
      false
    end

    def favorited_by
      []
    end

    def favoritable?
      false
    end

    def retweet
      # Intentionally blank
    end

    def retweet?
      nil
    end

    def retweeted?
      false
    end

    def retweeted_by
      []
    end

    def retweetable?
      false
    end

    def retweet_source(_=nil)
      nil
    end

    def quoting?
      false
    end

    def has_receive_message?
      false
    end

    def to_show
      @to_show ||= self[:title].gsub(/&(gt|lt|quot|amp);/){|m| {'gt' => '>', 'lt' => '<', 'quot' => '"', 'amp' => '&'}[$1] }.freeze
    end

    def to_message
      self
    end
    alias :message :to_message

    def system?
      false
    end

    def modified
      created
    end

    def from_me?
      false
    end

    def to_me?
      true
    end

    def user
      site!
    end

    def idname
      site!.idname
    end

    def repliable?
      false
    end

    def perma_link
      link
    end

    def receive_user_screen_names
      []
    end
  end
end
