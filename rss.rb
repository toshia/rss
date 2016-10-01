# -*- coding: utf-8 -*-
require 'rss'
require_relative 'model'

Plugin.create(:rss) do

  filter_extract_datasources do |ds|
    [ds.merge(rss: 'RSS')]
  end

  def tick
    site_urls = ['http://news.yahoo.co.jp/pickup/rss.xml']
    site_urls.each do |site_url|
      Thread.new{
        open(site_url).read
      }.next{|doc|
        RSS::Parser.parse(doc)
      }.next{|rss|
        channel = rss.channel
        [Plugin::RSS::Site.new(name: channel.title,
                               description: channel.description,
                               link: channel.link,
                               created: channel.lastBuildDate,
                               feed_url: site_url,
                               profile_image_url: Skin.get('icon.png')
                              ), rss]
      }.next{|site, rss|
        rss.items.map do |item|
          Plugin::RSS::Item.new(guid: item.guid.content,
                                link: item.link,
                                title: item.title,
                                description: item.description,
                                created: item.pubDate,
                                site: site)
        end
      }.next{|items|
        Plugin.call(:appear, items)
        Plugin.call :extract_receive_message, :rss, items
      }.trap{ |err|
        error err
      }
    end
    Reserver.new(60){ tick }
  end

  tick
end
