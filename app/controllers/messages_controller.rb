class MessagesController < InheritedResources::Base
  actions :all, except: [ :index, :show, :new, :create, :edit, :update, :destroy ]
end
