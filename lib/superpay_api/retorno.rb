# -*- encoding : utf-8 -*-
module SuperpayApi
  class Retorno

    # Validações do Rails 3
    include ActiveModel::Validations

    # Código que identifica a transação dentro do SuperPay
    # Numérico - Até 8 dígitos
    attr_accessor :numero_transacao

    # Código que identifica o estabelecimento dentro do SuperPay (fornecido pelo gateway)
    # Enviado pelo SuperPay
    attr_accessor :codigo_estabelecimento

    # Código da forma de pagamento. Ver tabela “Forma de Pagamento”
    # Simbolo - Valores pré-definidos - Verifique classe SuperpayApi::FormaDePagamento
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
    # Simbolo - Valores pré-definidos - Verifique classe SuperpayApi::Status
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

    # Retorna o status conforme classe SuperpayApi::Status
    def status
      @status ||= SuperpayApi::Status::STATUS[self.status_transacao.to_i]
    end

    # Nova instancia da classe Retorno
    # @param [Hash] campos
    def initialize(campos = {})
      campos.each do |campo, valor|
        if SuperpayApi::Retorno.public_instance_methods.include? "#{campo}=".to_sym
          send "#{campo}=", valor.to_s
        end
      end
    end

  end
end
