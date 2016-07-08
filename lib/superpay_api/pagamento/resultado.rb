# -*- encoding : utf-8 -*-
module SuperpayApi
  module Pagamento
    class Resultado

      MAPPING = {
        :numero_transacao             => "numeroTransacao",
        :codigo_estabelecimento       => "codigoEstabelecimento",
        :codigo_forma_pagamento       => "codigoFormaPagamento",
        :valor                        => "valor",
        :valor_desconto               => "valorDesconto",
        :taxa_embarque                => "taxaEmbarque",
        :parcelas                     => "parcelas",
        :url_pagamento                => "urlPagamento",
        :status_transacao             => "statusTransacao",
        :autorizacao                  => "autorizacao",
        :codigo_transacao_operadora   => "codigoTransacaoOperadora",
        :data_aprovacao_operadora     => "dataAprovacaoOperadora",
        :numero_comprovante_venda     => "numeroComprovanteVenda",
        :mensagem_venda               => "mensagemVenda",
      }

      # Após o envio da requisição, o SuperPay retornará um objeto de resposta, chamado ResultadoPagamentosWS,
      # como dado de saída. Tal objeto possui todas as informações necessárias para validar o resultado da transação e assim,
      # liberar ou não o pedido para o cliente final.

      # Código que identifica a transação dentro do SuperPay
      # Numérico - Até 8 dígitos
      attr_accessor :numero_transacao

      # Código que identifica o estabelecimento dentro do SuperPay (fornecido pelo gateway)
      # Numérico - Enviado pelo SuperPay
      attr_accessor :codigo_estabelecimento

      # Código da forma de pagamento. Ver tabela “Forma de Pagamento”
      # Numérico - Valores pré-definidos
      attr_accessor :codigo_forma_pagamento

      # Valor da transação
      # Sempre enviar o valor sem vírgula ou ponto, os dois últimos dígitos são sempre considerados como centavos.
      # Numérico - Até 10 dígitos
      attr_accessor :valor

      # Valor do desconto da transação
      # Sempre enviar o valor sem vírgula ou ponto, os dois últimos dígitos são sempre considerados como centavos.
      # Numérico - Até 10 dígitos
      attr_accessor :valor_desconto

      # Valor da taxa de embarque
      # Sempre enviar o valor sem vírgula ou ponto, os dois últimos dígitos são sempre considerados como centavos.
      # Numérico - Até 10 dígitos
      attr_accessor :taxa_embarque

      # Quantidade de parcelas da transação. Verificar se forma de pagamento suporta parcelamento
      # Numérico - Até 2 dígitos
      attr_accessor :parcelas

      # Para o modelo redirect. Essa será a URL de redirecionamento da operação.
      # Alfa Numérico - Até 500 caracteres
      attr_accessor :url_pagamento

      # Código que mostra o status atual da transação. Verificar tabela “Status”
      # Numérico - Até 2 dígitos
      attr_accessor :status_transacao

      # Código de autorização da operadora/banco/intermediário financeiro
      # Numérico - Até 20 dígitos
      attr_accessor :autorizacao

      # Código da transação na operadora/banco/intermediário financeiro
      # Numérico - Até 20 dígitos
      attr_accessor :codigo_transacao_operadora

      # Data de aprovação na operadora
      # Alfa Numérico - Até 10 caracteres
      attr_accessor :data_aprovacao_operadora

      # Número do comprovante de venda
      # Alfa Numérico - Até 20 caracteres
      attr_accessor :numero_comprovante_venda

      # Mensagem de retorno da operadora
      # Alfa Numérico - Até 50 caracteres
      attr_accessor :mensagem_venda


      # Return the order status.
      # Will be mapped to the STATUS constant.
      def status
        @status ||= SuperpayApi::Utils::STATUS[mapping_for(:status)]
      end

    end
  end
end
