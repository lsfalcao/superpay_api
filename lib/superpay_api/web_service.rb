# -*- encoding : utf-8 -*-
require 'savon'

module SuperpayApi
  class WebService

    # Atributo para o cliente SOAP
    attr_reader :savon_client

    # Nova instancia da classe WebService
    # Será considerado o ambiente informado nas configurações
    def initialize
      @savon_client = Savon.client(
        wsdl: ::SuperpayApi.url,
        env_namespace: :soapenv,
        convert_request_keys_to: :lower_camelcase,
        namespace_identifier: :pag,
        namespaces: {
          "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
          "xmlns:pag" => "http://pagamentos.webservices.superpay.ernet.com.br/",
        }
      )
    end

    # Função que faz a requisição para consulta_transacao_completa
    def consulta_transacao_completa(numero_transacao)
      # Monta os parâmetros
      params = helper.build_request_consulta_transacao_completa(numero_transacao)

      # Faz a requisição para o wsdl
      begin
        retorno = @savon_client.call(:consulta_transacao_completa, message: params)
      rescue Savon::SOAPFault => error
        return helper.build_response_error(error)
      end

      # Verifica se a retorno veio correta ou se deu problema
      if retorno.blank?
        return {error: true}
      else
        return helper.build_response_retorno(retorno)
      end
    end

    # Função que faz a requisição para pagamento_transacao_completa
    def pagamento_transacao_completa(transacao)
      # Monta os parâmetros
      params = helper.build_request_pagamento_transacao_completa(transacao)

      # Faz a requisição para o wsdl
      begin
        retorno = @savon_client.call(:pagamento_transacao_completa, message: params)
      rescue Savon::SOAPFault => error
        return helper.build_response_error(error)
        # return helper.build_response_error({error: error.to_hash[:fault][:faultstring]})
      end

      # Verifica se a retorno veio correta ou se deu problema
      if retorno.blank?
        return {error: true}
      else
        return helper.build_response_retorno(retorno)
      end
    end

    private

      # Acesso ao helper
      def helper
        @helper ||= SuperpayApi::Helper.new
      end

  end
end
