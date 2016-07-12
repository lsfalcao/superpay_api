# -*- encoding : utf-8 -*-
module SuperpayApi
  class DadosUsuario

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

    # Código que identifica o cliente no estabelecimento.
    # Alfa Numérico - Até 20 caracteres
    attr_accessor :codigo_cliente

    # Identifica se o cliente é pessoa física ou jurídica. Ver tabela “Tipo Cliente”
    # Simbolo - Valores pré-definidos [:pessoa_fisica, :pessoa_juridica]
    attr_accessor :tipo_cliente

    # Nome do comprador
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :nome

    # E-mail do comprador
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :email

    # Documento principal do comprador
    # Alfa Numérico - Até 30 caracteres
    attr_accessor :documento

    # Documento complementar do comprador
    # Alfa Numérico - Até 30 caracteres
    attr_accessor :documento_2

    # M – Masculino / F – Feminino
    # Simbolo - Valores pré-definidos [:masculino, :feminino]
    attr_accessor :sexo

    # Data de nascimento do comprador. Formato dd/mm/yyyy
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :data_nascimento

    # Endereços
    # SuperpayApi::Endereco
    attr_accessor :endereco_comprador, :endereco_entrega

    # Telefones
    # SuperpayApi::Telefone
    attr_accessor :telefone_comprador, :telefone_adicional_comprador, :telefone_entrega, :telefone_adicional_entrega

    # Validações do Rails 3
    include ActiveModel::Validations

    # Retornar array com os possíveis sexos
    def self.sexos_validos
      SEXO.map{ |key, value| key }
    end

    # Retornar array com os possíveis tipos de cliente
    def self.tipos_de_cliente_validos
      TIPOS_DE_CLIENTE.map{ |key, value| key }
    end

    # Validações
    validates :sexo, inclusion: { in: SuperpayApi::DadosUsuario.sexos_validos }, allow_nil: true
    validates :tipo_cliente, inclusion: { in: SuperpayApi::DadosUsuario.tipos_de_cliente_validos }, allow_nil: true
    validates :codigo_cliente, length: { maximum: 20 }
    validates :nome, :email, length: { maximum: 100 }
    validates :documento, :documento_2, length: { maximum: 30 }
    validates :data_nascimento, length: { maximum: 10 }

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

    # Nova instancia da classe DadosUsuario
    # @param [Hash] campos
    def initialize(campos = {})
      campos.each do |campo, valor|
        if SuperpayApi::DadosUsuario.public_instance_methods.include? "#{campo}=".to_sym
          send "#{campo}=", valor
        end
      end
    end

    # Retornar o número do tipo de telefone no padrão utilizado pelo SuperPay
    def sexo_to_request
      SEXO[self.sexo]
    end

    # Retornar o número do tipo de telefone no padrão utilizado pelo SuperPay
    def tipos_de_cliente_to_request
      TIPOS_DE_CLIENTE[self.tipo_cliente]
    end

    # Montar o Hash de dados do usuario no padrão utilizado pelo SuperPay
    def to_request
      dados_usuario = {
        codigo_cliente:             self.codigo_cliente,
        tipo_cliente:               self.tipos_de_cliente_to_request,
        nome_comprador:             self.nome,
        documento_comprador:        self.documento,
        documento_2_comprador:      self.documento_2,
        sexo_comprador:             self.sexo_to_request,
        data_nascimento_comprador:  self.data_nascimento,
        email_comprador:            self.email,
      }
      # Adiciona os dados de endereços
      dados_usuario.merge! self.endereco_comprador.to_request("endereco_comprador") unless endereco_comprador.blank?
      dados_usuario.merge! self.endereco_entrega.to_request("endereco_entrega") unless endereco_entrega.blank?

      # Adiciona os dados de telefones
      dados_usuario.merge! self.telefone_comprador.to_request("comprador") unless telefone_comprador.blank?
      dados_usuario.merge! self.telefone_adicional_comprador.to_request("adicional_comprador") unless telefone_adicional_comprador.blank?
      dados_usuario.merge! self.telefone_entrega.to_request("entrega") unless telefone_entrega.blank?
      dados_usuario.merge! self.telefone_adicional_entrega.to_request("adicional_entrega") unless telefone_adicional_entrega.blank?

      return dados_usuario
    end

  end
end
