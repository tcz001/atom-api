class GameVersion < ActiveRecord::Base
  belongs_to :game
  #TODO: 这里的i18n只是个例子，以后需要提供配置文件来加载
  @@i18n = {
      language: {
          EN: '英文版',
          JP: '日文版',
          ZH_CN: '中文版',
          ZH_HK: '香港繁体版',
      },
  }
  def display_language
    @@i18n[:language][self.language.to_sym]
  end
end
