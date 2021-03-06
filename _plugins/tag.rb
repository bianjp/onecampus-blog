module Jekyll
  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      process(@name)
      read_yaml(File.join(base, 'template'), 'tag.html')
      data['tag'] = tag

      tag_title_prefix = site.config['tag_title_prefix'] || 'Tag: '
      data['title'] = "#{tag_title_prefix}#{tag}"
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      dir = site.config['tag_dir'] || 'tags'
      site.tags.each_key do |tag|
        site.pages << TagPage.new(site, site.source, File.join(dir, tag), tag)
      end
    end
  end
end
