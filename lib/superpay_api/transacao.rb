# -*- encoding : utf-8 -*-
module SuperpayApi
  class Transacao

    # Código que identifica a transação dentro do SuperPay
    # Numérico - Até 8 dígitos
    attr_accessor :numero_transacao

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
    # Alfa Numérico - Até 7 caracteres - Formato mm/yyyy
    attr_accessor :data_validade_cartao

    # Data de validade do boleto.
    # Alfa Numérico - Até 10 caracteres - Formato dd/mm/yyyy
    attr_accessor :vencimento_boleto

    # Para o modelo de pagamento redirect, O SuperPay redirecionará para essa URL em caso de transação *aprovada
    # Alfa Numérico - Até 250 caracteres
    attr_accessor :url_redirecionamento_pago

    # Para o modelo de pagamento redirect, O SuperPay redirecionará para essa URL em caso de transação *reprovada
    # Alfa Numérico - Até 250 caracteres
    attr_accessor :url_redirecionamento_nao_pago

    # Número do IP do usuário final/cliente.
    # Alfa Numérico - Até 15 caracteres Formato xxx.xxx.xxx.xxx
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

    # Nova instancia da classe Transacao
    # @param [Hash] campos
    def initialize(campos = {})
      campos.each do |campo, valor|
        if SuperpayApi::Transacao.public_instance_methods.include? "#{campo}=".to_sym
          send "#{campo}=", valor
        end
      end
    end

    # Função para consultar transações
    # numero_transacao => :integer
    def consulta_transacao numero_transacao
      web_service.consulta_transacao_completa numero_transacao
    end

    # Função para consultar transações
    # numero_transacao => :integer
    def self.consulta_transacao numero_transacao
      self.new.consulta_transacao numero_transacao
    end

    # Função para realizar o pagamento de transações
    def enviar_pagamento
      web_service.pagamento_transacao_completa self
    end

    # Função para Cancelar transação
    # numero_transacao => :integer
    def cancelar_transacao numero_transacao
      web_service.cancelar_transacao numero_transacao
    end

    # Função para Cancelar transação
    # numero_transacao => :integer
    def self.cancelar_transacao numero_transacao
      self.new.cancelar_transacao numero_transacao
    end

    # Função para Capturar transação
    # numero_transacao => :integer
    def capturar_transacao numero_transacao
      web_service.capturar_transacao numero_transacao
    end

    # Função para Capturar transação
    # numero_transacao => :integer
    def self.capturar_transacao numero_transacao
      self.new.capturar_transacao numero_transacao
    end

    # Função para Estorno de transação
    # numero_transacao => :integer
    # valor_estorno => :integer
    # Sempre enviar o valor sem vírgula ou ponto, os dois últimos dígitos são sempre considerados como centavos
    def estorno_de_transacao numero_transacao, valor_estorno
      web_service.estorno_de_transacao numero_transacao, valor_estorno
    end

    # Função para Estorno de transação
    # numero_transacao => :integer
    # valor_estorno => :integer
    # Sempre enviar o valor sem vírgula ou ponto, os dois últimos dígitos são sempre considerados como centavos
    def self.estorno_de_transacao numero_transacao, valor_estorno
      self.new.estorno_de_transacao numero_transacao, valor_estorno
    end

    # Montar o Hash da transação no padrão utilizado pelo SuperPay
    def to_request
      transacao = {
        numero_transacao:               self.numero_transacao,
        "IP" =>                         self.ip,
        codigo_forma_pagamento:         self.codigo_forma_pagamento,
        valor:                          self.valor,
        valor_desconto:                 self.valor_desconto,
        taxa_embarque:                  self.taxa_embarque,
        parcelas:                       self.parcelas,
        nome_titular_cartao_credito:    self.nome_titular_cartao_credito,
        numero_cartao_credito:          self.numero_cartao_credito,
        codigo_seguranca:               self.codigo_seguranca,
        data_validade_cartao:           self.data_validade_cartao,
        vencimento_boleto:              self.vencimento_boleto,
        url_redirecionamento_pago:      self.url_redirecionamento_pago,
        url_redirecionamento_nao_pago:  self.url_redirecionamento_nao_pago,
        campo_livre1:                   self.campo_livre1,
        campo_livre2:                   self.campo_livre2,
        campo_livre3:                   self.campo_livre3,
        campo_livre4:                   self.campo_livre4,
        campo_livre5:                   self.campo_livre5,
      }

      # Adicionar os parâmetros de configurações
      transacao.merge! SuperpayApi.configuracoes_to_request

      # Adicionar dados do usuário
      transacao[:dados_usuario_transacao] = self.dados_usuario_transacao.to_request unless self.dados_usuario_transacao.blank?

      # Adicionar itens do pedido
      transacao[:itens_do_pedido] = self.itens_do_pedido.collect{ |i| i.to_request } unless self.itens_do_pedido.blank?

      return transacao
    end

    private

      # Acesso ao web_service
      def web_service
        @web_service ||= SuperpayApi::WebService.new
      end

  end
end
