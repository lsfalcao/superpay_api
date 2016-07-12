# -*- encoding : utf-8 -*-
module SuperpayApi
  class ItemPedido

    # Código único que identifica cada produto.
    # Alfa Numérico - Até 20 caracteres
    attr_accessor :codigo_produto

    # Código que identifica categoria do produto.
    # Alfa Numérico - Até 20 caracteres
    attr_accessor :codigo_categoria

    # Nome do Produto
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :nome_produto

    # Quantidade comprada do produto
    # Numérico - Até 8 dígitos
    attr_accessor :quantidade_produto

    # Valor unitário do produto.
    # Sempre enviar o valor sem vírgula ou ponto, os dois últimos dígitos são sempre considerados como centavos.
    # Numérico - Até 10 dígitos
    attr_accessor :valor_unitario_produto

    # Nome da categoria do produto.
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :nome_categoria

    # Validações do Rails 3
    include ActiveModel::Validations

    # Validações
    validates :quantidade_produto, :valor_unitario_produto, numericality: true, allow_nil: true
    validates :codigo_produto, :codigo_categoria, length: { maximum: 20 }
    validates :nome_produto, :nome_categoria, length: { maximum: 100 }
    validates :quantidade_produto, length: { maximum: 8 }
    validates :valor_unitario_produto, length: { maximum: 10 }

    # Nova instancia da classe ItemPedido
    # @param [Hash] campos
    def initialize(campos = {})
      campos.each do |campo, valor|
        if SuperpayApi::ItemPedido.public_instance_methods.include? "#{campo}=".to_sym
          send "#{campo}=", valor
        end
      end
    end

    # Montar o Hash de dados do ItemPedido no padrão utilizado pelo SuperPay
    def to_request
      item_pedido = {
        codigo_produto:           self.codigo_produto,
        codigo_categoria:         self.codigo_categoria,
        nome_produto:             self.nome_produto,
        quantidade_produto:       self.quantidade_produto,
        valor_unitario_produto:   self.valor_unitario_produto,
        nome_categoria:           self.nome_categoria,
      }
      return item_pedido
    end

  end
end
