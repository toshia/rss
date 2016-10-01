# -*- coding: utf-8 -*-

module Plugin::RSS
  class Site < Retriever::Model
    field.string :name, required: true
    field.string :description
    field.string :link
    field.time   :created
    field.string :profile_image_url
    field.string :feed_url

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
end










