# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false
=begin

#每天切分一次日志文件

config.logger = Logger.new("#{Rails.root}/log/#{Rails.env}#{Date.today.to_s}.log", "daily")
#按日志文件大小切分,每50M切分一次（即每50M时轮换一次）
#config.logger = Logger.new("#{Rails.root}/log/#{Rails.env}1.log", 2, 51200000)


#必须加这一句，不然会以debug模式打印日志
config.logger.level = Logger::INFO 
#！注意： config.logger = Logger.new("#{Rails.root}/log/#{Rails.env}1.log", 2, 51200000)  中
#{Rails.env}1.log  这句代码，即找到当前启动模式的日志文件，若写成#{Rails.env}.log时，会报错，提示无权限修改
=end