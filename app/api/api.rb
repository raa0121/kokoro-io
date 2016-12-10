# see: http://www.bokukoko.info/entry/2016/01/01/Grape_on_Rails_%E3%81%A7_API_%E9%96%8B%E7%99%BA
module API
  class Root < Grape::API
    mount V1::Root
  end
end
