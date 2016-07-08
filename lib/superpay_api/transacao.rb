# -*- encoding : utf-8 -*-
module SuperpayApi
  class Transacao

    # Map all the attributes from Transacao.
    #
    MAPPING = {
      :numero_transacao               => "numeroTransacao",
      :codigo_estabelecimento         => "codigoEstabelecimento",
      :codigo_forma_pagamento         => "codigoFormaPagamento",
      :valor                          => "valor",
      :valor_desconto                 => "valorDesconto",
      :taxa_embarque                  => "taxaEmbarque",
      :parcelas                       => "parcelas",
      :nome_titular_cartao_credito    => "nomeTitularCartaoCredito",
      :numero_cartao_credito          => "numeroCartaoCredito",
      :codigo_seguranca               => "codigoSeguranca",
      :data_validade_cartao           => "dataValidadeCartao",
      :vencimento_boleto              => "vencimentoBoleto",
      :url_campainha                  => "urlCampainha",
      :url_redirecionamento_pago      => "urlRedirecionamentoPago",
      :url_redirecionamento_nao_pago  => "urlRedirecionamentoNaoPago",
      :ip                             => "ip",
      :idioma                         => "idioma",
      :origem_transacao               => "origemTransacao",
      :campo_livre1                   => "campoLivre1",
      :campo_livre2                   => "campoLivre2",
      :campo_livre3                   => "campoLivre3",
      :campo_livre4                   => "campoLivre4",
      :campo_livre5                   => "campoLivre5",
      :dados_usuario_transacao        => "dadosUsuarioTransacao",
      :itens_do_pedido                => "itensDoPedido",
    }

    # Código que identifica a transação dentro do SuperPay
    # Numérico - Até 8 dígitos
    attr_accessor :numero_transacao

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

    # Nome do titular do cartão de crédito (Exatamente como escrito no cartão)
    # Alfa Numérico - Até 16 caracteres
    attr_accessor :nome_titular_cartao_credito

    # Numero do cartão de crédito, sem espaços ou traços
    # Numérico - Até 22 caracteres
    attr_accessor :numero_cartao_credito

    # Código de segurança do cartão (campo não é armazenado pelo SuperPay)
    # Numérico - Até 4 caracteres
    attr_accessor :codigo_seguranca

    # Data de validade do cartão.
    # Alfa Numérico - Até 7 caracteres
    attr_accessor :data_validade_cartao

    # Formato mm/yyyy
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :vencimento_boleto

    # Para o modelo de pagamento redirect, O SuperPay redirecionará para essa URL em caso de transação *aprovada
    # Alfa Numérico - Até 250 caracteres
    attr_accessor :url_redirecionamento_pago

    # Para o modelo de pagamento redirect, O SuperPay redirecionará para essa URL em caso de transação *reprovada
    # Alfa Numérico - Até 250 caracteres
    attr_accessor :url_redirecionamento_nao_pago

    # Número do IP do usuário final/cliente. Formato xxx.xxx.xxx.xxx
    # Alfa Numérico - Até 15 caracteres
    attr_accessor :ip

    # Campo Livre 1
    # Alfa Numérico - Até 16 caracteres
    attr_accessor :campo_livre1

    # Campo Livre 2
    # Alfa Numérico - Até 16 caracteres
    attr_accessor :campo_livre2

    # Campo Livre 3
    # Alfa Numérico - Até 16 caracteres
    attr_accessor :campo_livre3

    # Campo Livre 4
    # Alfa Numérico - Até 16 caracteres
    attr_accessor :campo_livre4

    # Campo Livre 5
    # Alfa Numérico - Até 16 caracteres
    attr_accessor :campo_livre5

    # Informações para cobrança e entrega. Informações importantes para análise de fraude
    # SuperpayApi::DadosUsuario
    attr_accessor :dados_usuario_transacao

    # Lista com Itens que estão sendo comprados. Informações importantes para análise de fraude e intermediários financeiros
    # SuperpayApi::ItemPedido
    attr_accessor :itens_do_pedido

    # Validações do Rails 3
    include ActiveModel::Validations

    # Validações
    validates :numero_transacao, :codigo_forma_pagamento, :valor, :valor_desconto, :taxa_embarque, :parcelas, :numero_cartao_credito,
              :codigo_seguranca, numericality: true
    validates :codigo_forma_pagamento, inclusion: { in: SuperpayApi::FormaDePagamento.validos }
    validates :parcelas, length: { maximum: 2 }
    validates :codigo_seguranca, length: { maximum: 4 }
    validates :data_validade_cartao, length: { maximum: 7 }
    validates :numero_transacao, length: { maximum: 8 }
    validates :valor, :valor_desconto, :taxa_embarque, :vencimento_boleto, length: { maximum: 10 }
    validates :ip, length: { maximum: 15 }
    validates :nome_titular_cartao_credito, :campo_livre1, :campo_livre2, :campo_livre3, :campo_livre4, :campo_livre5, length: { maximum: 16 }
    validates :numero_cartao_credito, length: { maximum: 22 }
    validates :url_redirecionamento_pago, :url_redirecionamento_nao_pago, length: { maximum: 250 }

    validates_each [:dados_usuario_transacao], allow_nil: true do |record, attr, value|
      if value.is_a? SuperpayApi::DadosUsuario
        if value.invalid?
          value.errors.full_messages.each { |msg| record.errors.add(attr, msg) }
        end
      else
        record.errors.add(attr, 'deve ser um objeto SuperpayApi::DadosUsuario.')
      end
    end

    validates_each [:itens_do_pedido], allow_nil: true do |record, attr, value|
      if value.is_a? Array
        value.each do |item_do_pedido|
          if item_do_pedido.is_a? SuperpayApi::ItemPedido
            if item_do_pedido.invalid?
              item_do_pedido.errors.full_messages.each { |msg| record.errors.add(attr, msg) }
            end
          else
            record.errors.add(attr, 'deve ser um objeto SuperpayApi::ItemPedido.')
          end
        end
      else
        record.errors.add(attr, 'deve ser uma coleção (Array).')
      end
    end

    # def consultar(parametros)
    #   resposta = web_service.request(parametros)
    #   helper.build_response_calculo_frete(resposta)
    # end

    # def self.consultar(parametros)
    #   self.new.consultar(parametros)
    # end

    # private

    # def web_service
    #   @web_service ||= SuperpayApi::Service::WebService.new
    # end

    # def helper
    #   @helper ||= SuperpayApi::Service::Helper.new
    # end

  end
end
