# -*- encoding : utf-8 -*-
module SuperpayApi
  module Configuracao

    # Endereço do wsdl funções:
    # [Criar Transação pagamentoTransacaoCompleta, Capturar operacaoTransacao, Cancelar operacaoTransacao, Consultar consultaTransacaoEspecifica]
    # [Estornar estornaTransacao] - Estorno
    URL = {
      :homologacao          => "https://homologacao.superpay.com.br/superpay/servicosPagamentoCompletoWS.Services?wsdl",
      :homologacao_estorno  => "https://homologacao.superpay.com.br/superpay/servicosEstornoWS.Services?wsdl",
      :producao             => "https://superpay2.superpay.com.br/checkout/servicosPagamentoCompletoWS.Services?wsdl",
      :producao_estorno     => "https://superpay2.superpay.com.br/checkout/servicosEstornoWS.Services?wsdl",
    }

    # Opções de idiomas
    IDIOMAS = {
      :portugues  => 1,
      :ingles     => 2,
      :espanhol   => 3,
    }

    # Opções de Origem da Transação
    # Consulte área de suporte sobre a habilitação das origens
    ORIGEM_DA_TRANSACAO ={
      :ecommerce  => 1,
      :mobile     => 2,
      :ura        => 3,
      :pos        => 4,
    }

    # Retornar array com os possíveis idiomas
    def self.validos
      IDIOMAS.map{ |key, value| key }
    end

    # Retornar array com as possíveis Origem da Transação
    def self.origem_da_transacao_validos
      ORIGEM_DA_TRANSACAO.map{ |key, value| key }
    end

    # Parâmetros iniciais
    URL_CAMPAINHA      = 'http://localhost:3000'
    # Parâmetros iniciais
    IDIOMA             = :portugues
    # Parâmetros iniciais
    ORIGEM_TRANSACAO   = :ecommerce
    # Parâmetros iniciais
    AMBIENTE           = :homologacao # :homologacao ou :producao
    # Parâmetros iniciais
    USUARIO            = 'superpay'
    # Parâmetros iniciais
    SENHA              = 'superpay'
    # Parâmetros iniciais
    ESTABELECIMENTO    = 1010101010101010

    # Define o ambiente de trabalho
    # Simbolo - Valores pré-definidos [:homologacao, :producao]
    attr_writer :ambiente

    # Código que identifica o estabelecimento dentro do SuperPay (fornecido pelo gateway)
    # Enviado pelo SuperPay
    attr_writer :estabelecimento

    # URL será sempre acionada quando o status do pedido mudar. Deve estar preparada para receber dados de campainha
    # Alfa Numérico - Até 250 caracteres
    attr_writer :url_campainha

    # Código do idioma. Ver tabela “Idiomas”
    # Simbolo - Valores pré-definidos
    attr_writer :idioma

    # Código do ambiente de origem. Verificar tabela “Ambientes de Origem”
    # Simbolo - Valores pré-definidos
    attr_writer :origem_transacao

    # Enviado pelo SuperPay
    attr_writer :usuario

    # Enviado pelo SuperPay
    attr_writer :senha

    # Comando que recebe as configuracoes
    def configure
      yield self if block_given?
    end

    # Definir ambiente
    def ambiente
      @ambiente ||= AMBIENTE
    end

    # Definir url_campainha
    def url_campainha
      @url_campainha ||= URL_CAMPAINHA
    end

    # Definir idioma
    def idioma
      @idioma ||= IDIOMA
    end

    # Definir origem_transacao
    def origem_transacao
      @origem_transacao ||= ORIGEM_TRANSACAO
    end

    # Definir usuario
    def usuario
      @usuario ||= USUARIO
    end

    # Definir senha
    def senha
      @senha ||= SENHA
    end

    # Definir estabelecimento
    def estabelecimento
      @estabelecimento ||= ESTABELECIMENTO
    end

    # Montar o Hash de Login no padrão utilizado pelo SuperPay
    def login
      login = {
        usuario: usuario.to_s,
        senha: senha.to_s,
      }
      return login
    end

    # Retornar o número do idioma no padrão utilizado pelo SuperPay
    def idiomas_to_request
      IDIOMAS[self.idioma].to_i
    end

    # Retornar o número da origem da transacao no padrão utilizado pelo SuperPay
    def origem_da_transacao_to_request
      ORIGEM_DA_TRANSACAO[self.origem_transacao].to_i
    end

    # Montar o Hash de configurações no padrão utilizado pelo SuperPay
    def configuracoes_to_request
      configuracoes = {
        codigo_estabelecimento:   self.estabelecimento.to_i,
        url_campainha:            self.url_campainha.to_s,
        idioma:                   self.idiomas_to_request,
        origem_transacao:         self.origem_da_transacao_to_request,
      }
      return configuracoes
    end

    # Retornar a url conforme o ambiente
    def url
      if ambiente == :producao
        SuperpayApi::Configuracao::URL[:producao]
      else
        SuperpayApi::Configuracao::URL[:homologacao]
      end
    end

    # Retornar a url conforme o ambiente
    def url_estorno
      if ambiente == :producao
        SuperpayApi::Configuracao::URL[:producao_estorno]
      else
        SuperpayApi::Configuracao::URL[:homologacao_estorno]
      end
    end

  end
end
