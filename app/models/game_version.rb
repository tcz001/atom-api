class GameVersion < ActiveRecord::Base
  belongs_to :game
  @@i18n = {
      language: {
          0 => '英文版',
          1 => '日文版',
          2 => '中文版',
          3 => '香港繁体版',
      },
      version: {
          0 => '港版',
          1 => '美版',
          2 => '日版',
          3 => '国行',
      },
  }
  def display_language
    @@i18n[:language][self.language]
  end
  def display_version
    @@i18n[:version][self.version]
  end
end
