# -*- encoding : utf-8 -*-
module SuperpayApi
  class Helper

    # #
    # # Montar o Hash com a requisão de calculo de frete
    # def build_request_calculo_frete(parametros = {})

    #   # Valida os parâmetros informados
    #   erros_params = ""
    #   erros_params << "Parâmetro obrigatório: login\n" if parametros[:login].blank?
    #   erros_params << "Parâmetro obrigatório: cep_origem\n" if parametros[:cep_origem].blank?
    #   erros_params << "Parâmetro obrigatório: cnpj_remetente\n" if parametros[:cnpj_remetente].blank?
    #   erros_params << "Parâmetro obrigatório: ie_remetente\n" if parametros[:ie_remetente].blank?
    #   erros_params << "Parâmetro obrigatório: cep_destino\n" if parametros[:cep_destino].blank?
    #   erros_params << "Parâmetro obrigatório: cpf_destinatario\n" if parametros[:cpf_destinatario].blank?
    #   erros_params << "Parâmetro obrigatório: valor_total\n" if parametros[:valor_total].blank?
    #   erros_params << "Parâmetro obrigatório: peso\n" if parametros[:peso].blank?
    #   raise erros_params unless erros_params.blank?

    #   params = {
    #     in0: {
    #       login: parametros[:login],
    #       cepOrigem: parametros[:cep_origem],
    #       nrIdentifClienteRem: parametros[:cnpj_remetente],
    #       nrInscricaoEstadualRemetente: parametros[:ie_remetente],

    #       cepDestino: parametros[:cep_destino],
    #       nrIdentifClienteDest: parametros[:cpf_destinatario],

    #       vlMercadoria: parametros[:valor_total],
    #       psReal: parametros[:peso],
    #     }
    #   }

    #   # Adiciona as configurações padrões
    #   params[:in0].merge! SuperpayApi::Service.configuracoes_calculo_frete

    #   return params
    # end

    # #
    # # Montar o Hash com a resposta de calculo de frete
    # def build_response_calculo_frete(resposta = {})
    #   response = {}
    #   if resposta.blank? or resposta[:calcula_frete_response].blank? or !resposta[:error].blank? or !resposta[:calcula_frete_response][:out][:error_list][:string].blank?
    #     response[:sucesso?]       = false
    #     if resposta[:error].blank?
    #       response[:error]        = resposta[:calcula_frete_response][:out][:error_list][:string]
    #     else
    #       response[:error]        = resposta[:error].to_s
    #     end
    #     response[:valor]          = 0
    #     response[:prazo_entrega]  = 0
    #   else
    #     response[:sucesso?]       = true
    #     response[:error]          = ''
    #     response[:valor]          = resposta[:calcula_frete_response][:out][:vl_total_frete]
    #     response[:prazo_entrega]  = resposta[:calcula_frete_response][:out][:prazo_entrega]
    #   end
    #   return response
    # end

  end
end
