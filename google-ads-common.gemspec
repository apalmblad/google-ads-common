Gem::Specification.new do |s|

  # Basic information
  s.name = 'google-ads-common'
  s.version = AdsCommon::ApiConfig::ADS_COMMON_VERSION
  s.summary = "Common code for Google Ads APIs."
  s.description = "ads_common provides essential utilities shared by all Ads Ruby client libraries."

  # Files and dependencies
  s.files =  FileList['*.*',
      'Rakefile',
      "lib/**/*.rb",
      "doc/**/*.*",
      "test/**/*.*"].to_a
  s.require_path = 'lib'
  s.add_dependency('soap4r', '>= 1.5.8')
  s.add_dependency('httpclient', '>= 2.1.5.2')
  s.add_dependency('httpi', '~>0.7.9')

  # RDoc information
  s.has_rdoc = true
  s.extra_rdoc_files = ['README']
  s.rdoc_options << '--main' << 'README'

  # Metadata
  s.authors = ['Sergio Gomes', 'Danial Klimkin']
  s.email = 'api.sgomes@gmail.com'
  s.homepage = 'http://code.google.com/p/google-api-adwords-ruby/'
  s.rubyforge_project = 'google-ads-common'
  s.requirements << 'soap4r v1.5.8'
  s.requirements << 'httpclient v2.1.5.2 or greater'
  s.requirements << 'httpi v0.7.9 or greater'
end
