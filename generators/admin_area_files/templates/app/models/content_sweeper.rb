class ContentSweeper < ActionController::Caching::Sweeper
  observe Article, Comment, Settings

  def after_save(record)
    case record
    when ::Article, ::Settings
      remove_articles_cache
    when ::Comment
      case record.commentable
      when ::Article
        expire_article(record.commentable)
      end
    end

    remove_archive_cache
  end

  def after_destroy(record)
    after_save(record)
  end

  def expire_article(article)
    expire_page(article_permalink_path(article.published_at.year,article.published_at.month,article.published_at.day,article.permalink)) unless article.published_at.nil?
  end

  # removes all the articles pages
  def remove_articles_cache
    Article.find(:all).each do |article|
      expire_article(article)
    end
  end
  
  # removes the entirety of the articles folder which all the articles archive and
  # pagination stuff is cached in    
  def remove_archive_cache
    expire_action(:controller => '/articles', :action => 'index')
    expire_fragment(%r{/articles/page/*})
    expire_fragment(%r{/categories/*})
    articles_folder = ActionController::Base.page_cache_directory + '/articles/'
    FileUtils.rmtree articles_folder if File.exists? articles_folder      
  end

end