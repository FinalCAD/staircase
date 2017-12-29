require 'active_support/all'
# require 'active_support/concern'

require_relative 'composer/converter/base'
require_relative 'composer/converter/pdf_to_image'

require_relative 'composer/processors/pdf_to_png'

require_relative 'composer/export'
require_relative 'composer/import'
require_relative 'composer/model'

require_relative 'composer/stores/registry'

require_relative 'composer/models/base'
require_relative 'composer/models/file_base'
require_relative 'composer/models/dir_base'
require_relative 'composer/models/staircase'
require_relative 'composer/models/sector'
require_relative 'composer/models/zone'

# autoload :Path, 'composer/import/path'
require_relative 'composer/import/dir'
require_relative 'composer/import/path'
require_relative 'composer/import/virtual_path'
require_relative 'composer/import/dispatcher'
