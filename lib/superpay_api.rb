# -*- encoding : utf-8 -*-
require 'rubygems'
require 'active_model'

require "superpay_api/version"
require "superpay_api/configuracao"
require "superpay_api/helper"
require "superpay_api/utils"
require "superpay_api/web_service"
require "superpay_api/forma_de_pagamento"
require "superpay_api/status"

require "superpay_api/endereco"
require "superpay_api/telefone"
require "superpay_api/dados_usuario"
require "superpay_api/item_pedido"
require "superpay_api/transacao"
require "superpay_api/retorno"

# -*- encoding : utf-8 -*-
module SuperpayApi
  extend SuperpayApi::Configuracao
end