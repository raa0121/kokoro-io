# -*- coding: utf-8 -*-
require 'pusher'

Pusher.url = ENV['PUSHER_URL']
Pusher.logger = Rails.logger
