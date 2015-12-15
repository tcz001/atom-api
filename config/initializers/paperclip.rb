Paperclip::Attachment.default_options[:storage] = :qiniu
Paperclip::Attachment.default_options[:qiniu_credentials] = {
  :access_key => ENV['QINIU_ACCESS_KEY'],
  :secret_key => ENV['QINIU_SECRET_KEY']
}
Paperclip::Attachment.default_options[:bucket] = 'ecoolhub'
Paperclip::Attachment.default_options[:use_timestamp] = false
Paperclip::Attachment.default_options[:qiniu_host] =
  'http://qiniu.ecoolhub.com'
