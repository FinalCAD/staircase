require 'active_support/all'

require_relative 'composer/lib/grid'
require_relative 'composer/lib/size'
require_relative 'composer/lib/position'
require_relative 'composer/lib/sector_position'
require_relative 'composer/lib/text_position'
require_relative 'composer/lib/dimension'
require_relative 'composer/lib/point'
require_relative 'composer/lib/cursor'
require_relative 'composer/lib/safe_path'
require_relative 'composer/lib/virtual_path'

require_relative 'composer/converter/base'
require_relative 'composer/converter/pdf_to_image'

require_relative 'composer/processors/base'
require_relative 'composer/processors/pdf_to_png'
require_relative 'composer/processors/create_layout'
require_relative 'composer/processors/compose_grid'
require_relative 'composer/processors/annotate'
require_relative 'composer/processors/move_zone'
require_relative 'composer/processors/metadata/sector'
require_relative 'composer/processors/metadata/zone'

require_relative 'composer/metadata/base'
require_relative 'composer/metadata/text_position'
require_relative 'composer/metadata/polyline'

require_relative 'composer/export'
require_relative 'composer/import'
require_relative 'composer/model'

require_relative 'composer/stores/registry'

require_relative 'composer/models/base'
require_relative 'composer/models/file_base'
require_relative 'composer/models/staircase'
require_relative 'composer/models/sector'
require_relative 'composer/models/zone'

require_relative 'composer/import/dir'
require_relative 'composer/import/path'
require_relative 'composer/import/instantiate'
