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

    # Montar o Hash com a requisição para Cancelar Transação
    def build_request_cancelar_transacao numero_transacao
      # Montar os parâmetros para consulta
      params = {
        operacao: {
          codigo_estabelecimento: SuperpayApi.estabelecimento,
          numero_transacao: numero_transacao,
          operacao: 2,
        }
      }
      # Adiciona as configurações de login
      params.merge! SuperpayApi.login
    end

    # Montar o Hash com a requisição para Capturar Transação
    def build_request_capturar_transacao numero_transacao
      # Montar os parâmetros para consulta
      params = {
        operacao: {
          codigo_estabelecimento: SuperpayApi.estabelecimento,
          numero_transacao: numero_transacao,
          operacao: 1,
        }
      }
      # Adiciona as configurações de login
      params.merge! SuperpayApi.login
    end

    # Montar o Hash com a requisição para Capturar Transação
    def build_request_estorno_de_transacao numero_transacao, valor_estorno
      # Montar os parâmetros para consulta
      params = {
        codigo_estabelecimento: SuperpayApi.estabelecimento,
        numero_transacao: numero_transacao,
        valor_estorno: valor_estorno,
      }
    end

    # Montar o Hash com a resposta
    # [ResultadoPagamentosWS, ResultadoConsultaTransacaoWS]
    def build_response_retorno(resposta = {})
      response = resposta.to_array.first
      if !response[:consulta_transacao_completa_response].blank?
        return SuperpayApi::Retorno.new(response[:consulta_transacao_completa_response][:return])
      elsif !response[:pagamento_transacao_completa_response].blank?
        return SuperpayApi::Retorno.new(response[:pagamento_transacao_completa_response][:return])
      elsif !response[:estorna_transacao_response].blank?
        return response[:estorna_transacao_response][:return]
      else
        retorno = SuperpayApi::Retorno.new
        retorno.errors.add(:mensagem, "Resposta sem tratamento")
        return retorno
      end
    end

    # Montar o Hash com a resposta quando ocorre erro
    # O erro será registrado no objeto errors
    def build_response_error(resposta = {})
      retorno = SuperpayApi::Retorno.new
      retorno.errors.add(:code, resposta.to_hash[:fault][:faultcode]) unless resposta.to_hash[:fault][:faultcode].blank?
      retorno.errors.add(:mensagem, resposta.to_hash[:fault][:faultstring]) unless resposta.to_hash[:fault][:faultstring].blank?
      return retorno
    end

    # Monta string com a resposta do estorno
    def build_response_retorno_estorno(resposta = {})
      response = resposta.to_array.first
      if !response[:estorna_transacao_response].blank?
        return response[:estorna_transacao_response][:return]
      else
        return "Resposta sem tratamento"
      end
    end

    # Monta string com a resposta quando ocorre erro no estorno
    def build_response_error_estorno(resposta = {})
      unless resposta.to_hash[:fault][:faultstring].blank?
        return resposta.to_hash[:fault][:faultstring]
      else
        return "Resposta sem tratamento"
      end
    end

  end
end
