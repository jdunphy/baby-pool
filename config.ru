require File.expand_path(File.dirname(__FILE__) + '/baby_pool')

use Rack::Static, :urls => ["/css", "/images"], :root => "public"

run BabyPool
