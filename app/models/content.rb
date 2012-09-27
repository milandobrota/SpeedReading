class Content < ActiveRecord::Base
  has_many :questions, :dependent => :delete_all
  has_many :categorizations
  has_many :categories, :through => :categorizations
  belongs_to :language

  validates_presence_of :name, :body, :language

  before_save :expire_cache
  before_destroy :expire_cache

  has_attached_file :photo,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  def photo_url
    photo.url
  end

  def word_count
    body.scan(/\b/).size / 2
  end

  def language_name
    language.name
  end

  def expire_cache
    Rails.cache.clear
  end

  class << self
    def for_reading_test
      random
    end

    def for_find_the_word_test
      random
    end

    def random
      order('random()').first
    end

    def sorted_by_name
      Content.order('name asc')
    end

    def cached_filter(filter)
      Rails.cache.fetch("content_with_category_id_#{filter[:category_id]}_and_language_id_#{filter[:language_id]}") do
        filter(filter)
      end
    end

    def filter(filter)
      filtered = Content
      
      if filter[:category_id]
        filtered = filtered.includes(:categorizations).where(['categorizations.category_id = ?', filter[:category_id]])
      end

      filtered = filtered.where(:language_id => filter[:language_id]) if filter[:language_id]
      filtered
    end
  end

end
