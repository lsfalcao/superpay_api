# -*- encoding : utf-8 -*-
module SuperpayApi
  module Configuracao

    MAPPING = {
      :ecommerce    => "eCommerce",
      :mobile       => "Mobile",
      :ura          => "URA",
      :pos          => "POS",
    }

    # Endereço do wsdl funções:
    # [Criar Transação pagamentoTransacaoCompleta, Capturar operacaoTransacao, Cancelar operacaoTransacao, Consultar consultaTransacaoEspecifica]
    # [Estornar estornaTransacao] - Estorna fica em wsdl separado
    URL = {
      :homologacao          => "https://homologacao.superpay.com.br/superpay/servicosPagamentoCompletoWS.Services?wsdl",
      :homologacao_estorno  => "https://homologacao.superpay.com.br/superpay/servicosEstornoWS.Services?wsdl",
      :producao             => "https://superpay2.superpay.com.br/checkout/servicosPagamentoCompletoWS.Services?wsdl",
      :producao_estorno     => "https://superpay2.superpay.com.br/checkout/servicosEstornoWS.Services?wsdl",
    }

    # Opções de Origem da Transação
    # Consulte área de suporte sobre a habilitação das origens
    ORIGEM_DA_TRANSACAO ={
      :ecommerce  => 1,
      :mobile     => 2,
      :ura        => 3,
      :pos        => 4,
    }

    # Retornar array com os possíveis Origem da Transação
    def self.origem_da_transacao_validos
      ORIGEM_DA_TRANSACAO.map{ |key, value| key }
    end

    # Parâmetros iniciais
    URL_CAMPAINHA      = 'http://localhost:3000'
    IDIOMA             = 1
    ORIGEM_TRANSACAO   = 1
    AMBIENTE           = :producao
    USUARIO            = 'superpay'
    SENHA              = 'superpay'
    ESTABELECIMENTO    = 1010101010101010

    # Define o ambiente de trabalho
    # Simbolo - Valores pré-definidos
    attr_writer :ambiente

    # Código que identifica o estabelecimento dentro do SuperPay (fornecido pelo gateway)
    # Numérico - Enviado pelo SuperPay
    attr_writer :estabelecimento

    # URL será sempre acionada quando o status do pedido mudar. Deve estar preparada para receber dados de campainha
    # Alfa Numérico - Até 250 caracteres
    attr_writer :url_campainha

    # Código do idioma. Ver tabela “Idiomas”
    # Numérico - Valores pré-definidos
    attr_writer :idioma

    # Código do ambiente de origem. Verificar tabela “Ambientes de Origem”
    # Numérico - Valores pré-definidos
    attr_writer :origem_transacao

    # Enviado pelo SuperPay
    attr_writer :usuario

    # Enviado pelo SuperPay
    attr_writer :senha

    #
    # Comando que recebe as configuracoes
    def configure
      yield self if block_given?
    end

    #
    # Opções para o ambiente
    # :teste para o Ambiente de Testes
    # :producao para o Ambiente de Produção (default)
    def ambiente
      @ambiente ||= AMBIENTE
    end

    #
    # Definir o usuario
    # Enviado pelo SuperPay
    def url_campainha
      @url_campainha ||= URL_CAMPAINHA
    end

    #
    # Definir o usuario
    # Enviado pelo SuperPay
    def idioma
      @idioma ||= IDIOMA
    end

    #
    # Definir o usuario
    # Enviado pelo SuperPay
    def origem_transacao
      @origem_transacao ||= ORIGEM_TRANSACAO
    end

    #
    # Definir o usuario
    # Enviado pelo SuperPay
    def usuario
      @usuario ||= USUARIO
    end

    #
    # Definir a senha
    # Enviado pelo SuperPay
    def senha
      @senha ||= SENHA
    end

    #
    # Código que identifica o estabelecimento dentro do SuperPay (fornecido pelo gateway)
    # Enviado pelo SuperPay
    def estabelecimento
      @estabelecimento ||= ESTABELECIMENTO
    end

    #
    # Montar o Hash de configurações
    # def configuracoes_calculo_frete
    #   configuracoes = {
    #     cdDivisaoCliente: divisao_cliente,
    #     tpSituacaoTributariaDestinatario: situacao_tributaria_destinatario,
    #     tpSituacaoTributariaRemetente: situacao_tributaria_remetente,
    #     tpPessoaRemetente: tipo_pessoa_remetente,
    #     tpPessoaDestinatario: tipo_pessoa_destinatario,
    #     tpServico: tipo_servico,
    #     tpFrete: tipo_frete,
    #   }
    #   return configuracoes
    # end

  end
end
