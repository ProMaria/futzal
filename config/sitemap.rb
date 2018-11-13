require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://futzal-koaf.ru'
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9
  add '/doc', :changefreq => 'weekly'
  add '/referee', :changefreq => 'monthly'
  add '/team?league_id=1', :changefreq => 'monthly'
  add '/team?league_id=2', :changefreq => 'monthly'
  add '/table/1/team_position', :changefreq => 'weekly'
  add '/table/2/team_position', :changefreq => 'weekly'
  add '/items', :changefreq => 'weekly'
  add '/contacts', :changefreq => 'monthly'
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks