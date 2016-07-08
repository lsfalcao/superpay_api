# -*- encoding : utf-8 -*-
module SuperpayApi
  class DadosUsuario

    MAPPING = {
      :masculino                      => "Masculino",
      :feminino                       => "Feminino",
      :pessoa_fisica                  => "Pessoa Física",
      :pessoa_juridica                => "Pessoa Jurídica",
      :codigo_cliente                 => "codigoCliente",
      :tipo_cliente                   => "tipoCliente",
      :nome_comprador                 => "nomeComprador",
      :email_comprador                => "emailComprador",
      :documento_comprador            => "documentoComprador",
      :documento_2_comprador          => "documento2Comprador",
      :sexo_comprador                 => "sexoComprador",
      :data_nascimento_comprador      => "dataNascimentoComprador",
      :endereco_comprador             => "enderecoComprador",
      :telefone_comprador             => "telefoneComprador",
      :telefone_adicional_comprador   => "telefoneAdicionalComprador",
      :endereco_entrega               => "enderecoEntrega",
      :telefone_entrega               => "telefoneEntrega",
      :telefone_adicional_entrega     => "telefoneAdicionalEntrega",
    }

    # Opções de Sexo
    SEXO = {
      :masculino  => "M",
      :feminino   => "F",
    }

    # Opções de Tipo de Cliente
    TIPOS_DE_CLIENTE = {
      :pessoa_fisica    => 1,
      :pessoa_juridica  => 2,
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

    # E-mail do comprador
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :email_comprador

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

    # Endereços
    # SuperpayApi::Endereco
    attr_accessor :endereco_comprador, :endereco_entrega

    # Telefones
    # SuperpayApi::Telefone
    attr_accessor :telefone_comprador, :telefone_adicional_comprador, :telefone_entrega, :telefone_adicional_entrega

    # Validações do Rails 3
    include ActiveModel::Validations

    # Retornar array com os possíveis idiomas
    def self.sexos_validos
      SEXO.map{ |key, value| key }
    end

    # Retornar array com os possíveis tipos de cliente
    def self.tipos_de_cliente_validos
      TIPOS_DE_CLIENTE.map{ |key, value| key }
    end

    # Validações
    validates :sexo_comprador, inclusion: { in: SuperpayApi::DadosUsuario.sexos_validos }, allow_nil: true
    validates :tipo_cliente, inclusion: { in: SuperpayApi::DadosUsuario.tipos_de_cliente_validos }, allow_nil: true
    validates :codigo_cliente, length: { maximum: 20 }
    validates :nome_comprador, :email_comprador, length: { maximum: 100 }
    validates :documento_comprador, :documento_2_comprador, length: { maximum: 30 }
    validates :data_nascimento_comprador, length: { maximum: 10 }

    validates_each [:endereco_comprador, :endereco_entrega], allow_nil: true do |record, attr, value|
      if value.is_a? SuperpayApi::Endereco
        if value.invalid?
          value.errors.full_messages.each { |msg| record.errors.add(attr, msg) }
        end
      else
        record.errors.add(attr, 'deve ser um objeto SuperpayApi::Endereco.')
      end
    end

    validates_each [:telefone_comprador, :telefone_adicional_comprador, :telefone_entrega, :telefone_adicional_entrega], allow_nil: true do |record, attr, value|
      if value.is_a? SuperpayApi::Telefone
        if value.invalid?
          value.errors.full_messages.each { |msg| record.errors.add(attr, msg) }
        end
      else
        record.errors.add(attr, 'deve ser um objeto SuperpayApi::Telefone.')
      end
    end

  end
end
