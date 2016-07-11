# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'superpay_api/version'

Gem::Specification.new do |gem|
  gem.name                  = "superpay_api"
  gem.version               = SuperpayApi::Version::STRING
  gem.platform              = Gem::Platform::RUBY
  gem.authors               = ["QW3 Software & Marketing"]
  gem.email                 = ["contato@qw3.com.br"]
  gem.summary               = "SuperPay API - Gateway de pagamento"
  gem.description           = "Gem para utilização do SuperPay API disponibilizado pela empresa SuperPay para integrar sua plataforma de forma segura e eficaz com as principais formas de pagamento disponíveis no mercado."
  gem.homepage              = "https://github.com/qw3/superpay_api"
  gem.license               = "MIT"

  gem.files                 = [
                                "lib/superpay_api.rb",
                                "lib/superpay_api/version.rb",
                                "lib/superpay_api/configuracao.rb",
                                "lib/superpay_api/helper.rb",
                                "lib/superpay_api/utils.rb",
                                "lib/superpay_api/web_service.rb",
                                "lib/superpay_api/forma_de_pagamento.rb",
                                "lib/superpay_api/status.rb",
                                "lib/superpay_api/endereco.rb",
                                "lib/superpay_api/telefone.rb",
                                "lib/superpay_api/dados_usuario.rb",
                                "lib/superpay_api/item_pedido.rb",
                                "lib/superpay_api/transacao.rb",
                                "lib/superpay_api/retorno.rb",
                              ]
  gem.require_paths         = ["lib"]

  gem.required_ruby_version = Gem::Requirement.new(">= 1.9")

  gem.add_dependency "activemodel",     ">= 3"
  gem.add_runtime_dependency "savon",   ">= 2.11"

end

