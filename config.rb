###
# Blog settings
###

# Time.zone = "UTC"
set :index_file, "index.html"
set :protocol, "http://"
set :host, "localhost"
set :port, 4567

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"

  blog.permalink = "{title}/index.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}"
  blog.taglink = "category/{tag}/index.html"
  blog.layout = "blogpost"
  # blog.summary_separator = /(READMORE)/
   blog.summary_length = 350
  # blog.year_link = "{year}"
  # blog.month_link = "{year}/{month}"
  # blog.day_link = "{year}/{month}/{day}"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 5
  blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

page "/blog/category/*", :layout => "blog"

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do
def nav_link(name, url, options={})
currentPage = current_page.url.gsub(/\/$/, '')

  options = {
    class: "",
    active_if: url,
    page: currentPage,
  }.update options
  a = options.delete(:active_if)
  active = Regexp === a ? currentPage =~ a : currentPage == a
  options[:class] += " active" if active

  link_to name, url, options
end

  def host_with_port
    [host, optional_port].compact.join(':')
  end

  def optional_port
    port unless port.to_i == 80
  end

  def absolute_url(source)
    protocol + host_with_port + source
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css
  activate :gzip
  activate :minify_html, :remove_input_attributes => false


  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :directory_indexes