# -*- encoding : utf-8 -*-
module SuperpayApi
  class ItemPedido

    MAPPING = {
      :codigo_produto           => "codigoProduto",
      :codigo_categoria         => "codigoCategoria",
      :nome_produto             => "nomeProduto",
      :quantidade_produto       => "quantidadeProduto",
      :valor_unitario_produto   => "valorUnitarioProduto",
      :nome_categoria           => "nomeCategoria",
    }

    # Importante ressaltar que todos os campos deste objeto são obrigatórios em caso de utilização de análise de fraude/risco.

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

  end
end
