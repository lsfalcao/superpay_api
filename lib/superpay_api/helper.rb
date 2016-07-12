# -*- encoding : utf-8 -*-
module SuperpayApi
  class Helper

    # Montar o Hash com a requisição de consulta transação completo
    def build_request_consulta_transacao_completa numero_transacao
      # Montar os parâmetros para consulta
      params = {
        consulta_transacao_w_s: {
          codigo_estabelecimento: SuperpayApi.estabelecimento,
          numero_transacao: numero_transacao,
        }
      }
      # Adiciona as configurações de login
      params.merge! SuperpayApi.login
    end

    # Montar o Hash com a requisição de pagamento transação completo
    def build_request_pagamento_transacao_completa transacao
      # Montar os parâmetros para pagamento transacao completa
      params = {}
      params[:transacao] = transacao.to_request
      # Adiciona as configurações de login
      params.merge! SuperpayApi.login
    end

    # Montar o Hash com a resposta quando ocorre erro
    # [ResultadoPagamentosWS, ResultadoConsultaTransacaoWS]
    def build_response_retorno(resposta = {})
      response = resposta.to_array.first
      if !response[:consulta_transacao_completa_response].blank?
        return SuperpayApi::Retorno.new(response[:consulta_transacao_completa_response][:return])
      elsif !response[:pagamento_transacao_completa_response].blank?
        return SuperpayApi::Retorno.new(response[:pagamento_transacao_completa_response][:return])
      else
        return resposta
      end
    end

    # Montar o Hash com a resposta quando ocorre erro
    def build_response_error(resposta = {})
      return resposta
    end

  end
end
