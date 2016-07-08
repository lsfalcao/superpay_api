# -*- encoding : utf-8 -*-
module SuperpayApi
  class DadosUsuarioOriginal

    # Validações do Rails 3
    # include ActiveModel::Validations

    MAPPING = {
      :codigo_cliente                             => "codigoCliente",
      :tipo_cliente                               => "tipoCliente",
      :nome_comprador                             => "nomeComprador",
      :documento_comprador                        => "documentoComprador",
      :documento_2_comprador                      => "documento2Comprador",
      :sexo_comprador                             => "sexoComprador",
      :data_nascimento_comprador                  => "dataNascimentoComprador",
      :telefone_comprador                         => "telefoneComprador",
      :ddd_comprador                              => "dddComprador",
      :ddi_comprador                              => "ddiComprador",
      :codigo_tipo_telefone_comprador             => "codigoTipoTelefoneComprador",
      :telefone_adicional_comprador               => "telefoneAdicionalComprador",
      :ddd_adicional_comprador                    => "dddAdicionalComprador",
      :ddi_adicional_comprador                    => "ddiAdicionalComprador",
      :codigo_tipo_telefone_adicional_comprador   => "codigoTipoTelefoneAdicionalComprador",
      :email_comprador                            => "emailComprador",
      :endereco_comprador                         => "enderecoComprador",
      :numero_endereco_comprador                  => "numeroEnderecoComprador",
      :bairro_endereco_comprador                  => "bairroEnderecoComprador",
      :complemento_endereco_comprador             => "complementoEnderecoComprador",
      :cidade_endereco_comprador                  => "cidadeEnderecoComprador",
      :estado_endereco_comprador                  => "estadoEnderecoComprador",
      :cep_endereco_comprador                     => "cepEnderecoComprador",
      :endereco_entrega                           => "enderecoEntrega",
      :numero_endereco_entrega                    => "numeroEnderecoEntrega",
      :bairro_endereco_entrega                    => "bairroEnderecoEntrega",
      :complemento_endereco_entrega               => "complementoEnderecoEntrega",
      :cidade_endereco_entrega                    => "cidadeEnderecoEntrega",
      :estado_endereco_entrega                    => "estadoEnderecoEntrega",
      :cep_endereco_entrega                       => "cepEnderecoEntrega",
      :telefone_entrega                           => "telefoneEntrega",
      :ddd_entrega                                => "dddEntrega",
      :ddi_entrega                                => "ddiEntrega",
      :codigo_tipo_telefone_entrega               => "codigoTipoTelefoneEntrega",
      :telefone_adicional_entrega                 => "telefoneAdicionalEntrega",
      :ddd_adicional_entrega                      => "dddAdicionalEntrega",
      :ddi_adicional_entrega                      => "ddiAdicionalEntrega",
      :codigo_tipo_telefone_adicional_entrega     => "codigoTipoTelefoneAdicionalEntrega",
    }

    # Importante ressaltar que todos os campos deste objeto são obrigatórios em caso de utilização de análise de fraude/risco.

    # Código que identifica o cliente no estabelecimento.
    # Alfa Numérico - Até 20 caracteres
    attr_accessor :codigo_cliente

    # Identifica se o cliente é pessoa física ou jurídica. Ver tabela “Tipo Cliente”
    # Numérico - 1 dígito
    attr_accessor :tipo_cliente

    # Nome do comprador
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :nome_comprador

    # Documento principal do comprador
    # Alfa Numérico - Até 30 caracteres
    attr_accessor :documento_comprador

    # Documento complementar do comprador
    # Alfa Numérico - Até 30 caracteres
    attr_accessor :documento_2_comprador

    # M – Masculino / F – Feminino
    # Alfa Numérico - 1 caractere
    attr_accessor :sexo_comprador

    # Data de nascimento do comprador. Formato dd/mm/yyyy
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :data_nascimento_comprador

    # Telefone do comprador sem espaços ou traços
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :telefone_comprador

    # DDD do telefone do comprador
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddd_comprador

    # DDI do telefone do comprador
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddi_comprador

    # Ver tabela “Tipos de Telefone”
    # Numérico - 1 dígito
    attr_accessor :codigo_tipo_telefone_comprador

    # Telefone adicional do comprador. Sem espaços ou traços
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :telefone_adicional_comprador

    # DDD do telefone adicional do comprador
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddd_adicional_comprador

    # DDI do telefone adicional do comprador
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddi_adicional_comprador

    # Tipo do telefone adicional. Ver tabela “Tipos de Telefone”
    # Numérico - 1 dígito
    attr_accessor :codigo_tipo_telefone_adicional_comprador

    # E-mail do comprador
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :email_comprador

    # Endereço (Logradouro) do comprador
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :endereco_comprador

    # Número do logradouro do comprador
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :numero_endereco_comprador

    # Bairro do logradouro do comprador
    # Alfa Numérico - Até 50 caracteres
    attr_accessor :bairro_endereco_comprador

    # Complemento do endereço comprador
    # Alfa Numérico - Até 50 caracteres
    attr_accessor :complemento_endereco_comprador

    # Cidade do logradouro do comprador
    # Alfa Numérico - Até 50 caracteres
    attr_accessor :cidade_endereco_comprador

    # Estado do logradouro do comprador
    # Alfa Numérico - Até 2 caracteres
    attr_accessor :estado_endereco_comprador

    # CEP do comprador. Enviar sem traços ou espaços
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :cep_endereco_comprador

    # Endereço (Logradouro) de entrega
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :endereco_entrega

    # Número do logradouro de entrega
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :numero_endereco_entrega

    # Bairro do logradouro de entrega
    # Alfa Numérico - Até 50 caracteres
    attr_accessor :bairro_endereco_entrega

    # Complemento do endereço de entrega
    # Alfa Numérico - Até 50 caracteres
    attr_accessor :complemento_endereco_entrega

    # Cidade do logradouro de entrega
    # Alfa Numérico - Até 50 caracteres
    attr_accessor :cidade_endereco_entrega

    # Estado do logradouro de entrega
    # Alfa Numérico - Até 2 caracteres
    attr_accessor :estado_endereco_entrega

    # CEP de entrega. Enviar sem traços ou espaços
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :cep_endereco_entrega

    # Telefone de entrega. Sem espaços ou traços
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :telefone_entrega

    # DDD do telefone de entrega
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddd_entrega

    # DDD do telefone de entrega
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddi_entrega

    # Ver tabela “Tipos de Telefone”
    # Numérico - 1 dígito
    attr_accessor :codigo_tipo_telefone_entrega

    # Telefone adicional de entrega. Sem espaços ou traços
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :telefone_adicional_entrega

    # DDD do telefone adicional de entrega
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddd_adicional_entrega

    # DDI do telefone adicional de entrega
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddi_adicional_entrega

    # Ver tabela “Tipos de Telefone”
    # Numérico - 1 dígito
    attr_accessor :codigo_tipo_telefone_adicional_entrega

    # Validações do Rails 3
    include ActiveModel::Validations

    # Validações
    validates :tipo_cliente, :codigo_tipo_telefone_comprador, :codigo_tipo_telefone_adicional_comprador, :codigo_tipo_telefone_entrega,
              :codigo_tipo_telefone_adicional_entrega, numericality: true, allow_nil: true
    validates :sexo_comprador, inclusion: { in: SuperpayApi::Utils.sexos_to_array }, allow_nil: true
    validates :tipo_cliente, inclusion: { in: SuperpayApi::Utils.tipos_de_cliente_to_array }, allow_nil: true
    validates :codigo_tipo_telefone_comprador, :codigo_tipo_telefone_adicional_comprador, :codigo_tipo_telefone_entrega,
              :codigo_tipo_telefone_adicional_entrega, inclusion: { in: SuperpayApi::Utils.tipos_de_telefone_to_array }, allow_nil: true
    validates :cep_endereco_comprador, :cep_endereco_entrega, :data_nascimento_comprador, :numero_endereco_comprador, :numero_endereco_entrega,
              :telefone_adicional_comprador, :telefone_adicional_entrega, :telefone_comprador, :telefone_entrega, length: { maximum: 10 }
    validates :email_comprador, :endereco_comprador, :endereco_entrega, :nome_comprador, length: { maximum: 100 }
    validates :estado_endereco_comprador, :estado_endereco_entrega, length: { maximum: 2 }
    validates :codigo_cliente, length: { maximum: 20 }
    validates :ddd_adicional_comprador, :ddd_adicional_entrega, :ddd_comprador, :ddd_entrega, :ddi_adicional_comprador, :ddi_adicional_entrega,
              :ddi_comprador, :ddi_entrega, length: { maximum: 3 }
    validates :documento_2_comprador, :documento_comprador, length: { maximum: 30 }
    validates :bairro_endereco_comprador, :bairro_endereco_entrega, :cidade_endereco_comprador, :cidade_endereco_entrega,
              :complemento_endereco_comprador, :complemento_endereco_entrega, length: { maximum: 50 }

  end
end


# -*- encoding : utf-8 -*-
module SuperpayApi
  module Pagamento
    class Transacao

      # Validações do Rails 3
      # include ActiveModel::Validations

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
      # Alfa Numérico - 7 caracteres
      attr_accessor :data_validade_cartao

      # Formato mm/yyyy
      # Alfa Numérico - 10 caracteres
      attr_accessor :vencimento_boleto

      # URL será sempre acionada quando o status do pedido mudar. Deve estar preparada para receber dados de campainha
      # Alfa Numérico - Até 250 caracteres
      attr_accessor :url_campainha

      # Para o modelo de pagamento redirect, O SuperPay redirecionará para essa URL em caso de transação *aprovada
      # Alfa Numérico - Até 250 caracteres
      attr_accessor :url_redirecionamento_pago

      # Para o modelo de pagamento redirect, O SuperPay redirecionará para essa URL em caso de transação *reprovada
      # Alfa Numérico - Até 250 caracteres
      attr_accessor :url_redirecionamento_nao_pago

      # Número do IP do usuário final/cliente. Formato xxx.xxx.xxx.xxx
      # Alfa Numérico - Até 15 caracteres
      attr_accessor :ip

      # Código do idioma. Ver tabela “Idiomas”
      # Numérico - Valores pré-definidos
      attr_accessor :idioma

      # Código do ambiente de origem. Verificar tabela “Ambientes de Origem”
      # Numérico - Valores pré-definidos
      attr_accessor :origem_transacao

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
      # Numérico - Objeto: DadosUsuarioTransacaoCompletaWS
      attr_accessor :dados_usuario_transacao

      # Lista com Itens que estão sendo comprados. Informações importantes para análise de fraude e intermediários financeiros
      # Numérico - ArrayList com objetos: ItemPedidoTransacaoWS
      attr_accessor :itens_do_pedido

      # Validações do Rails 3
      include ActiveModel::Validations

      # Validações
      validates :numero_transacao, :codigo_estabelecimento, :codigo_forma_pagamento, :valor, :valor_desconto, :taxa_embarque,
                :parcelas, :numero_cartao_credito, :codigo_seguranca, :idioma, :origem_transacao, :dados_usuario_transacao, :numericality: true
      validates :codigo_forma_pagamento, inclusion: { in: SuperpayApi::Utils.formas_de_pagamento_to_array }
      validates :idioma, inclusion: { in: SuperpayApi::Idioma.validos }
      validates :origem_transacao, inclusion: { in: SuperpayApi::Utils.origem_da_transacao_to_array }

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
end

