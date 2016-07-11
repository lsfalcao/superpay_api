# -*- encoding : utf-8 -*-
module SuperpayApi
  class Endereco

    # Endereço (Logradouro)
    # Alfa Numérico - Até 100 caracteres
    attr_accessor :logradouro

    # Número do logradouro
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :numero

    # Bairro do logradouro
    # Alfa Numérico - Até 50 caracteres
    attr_accessor :bairro

    # Complemento do endereço comprador
    # Alfa Numérico - Até 50 caracteres
    attr_accessor :complemento

    # Cidade do logradouro
    # Alfa Numérico - Até 50 caracteres
    attr_accessor :cidade

    # Estado do logradouro
    # Alfa Numérico - Até 2 caracteres
    attr_accessor :estado

    # CEP. Enviar sem traços ou espaços
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :cep

    # Validações do Rails 3
    include ActiveModel::Validations

    # Validações
    validates :logradouro, length: { maximum: 100 }
    validates :numero, :cep, length: { maximum: 10 }
    validates :bairro, :complemento, :cidade, length: { maximum: 50 }
    validates :estado, length: { maximum: 2 }

    # Nova instancia da classe Endereco
    # @param [Hash] campos
    def initialize(campos = {})
      campos.each do |campo, valor|
        if SuperpayApi::Endereco.public_instance_methods.include? "#{campo}=".to_sym
          send "#{campo}=", valor
        end
      end
    end

    # Montar o Hash de Endereco conforme o tipo dele
    def to_request tipo
      endereco = {}
      case tipo.to_sym
        when :endereco_comprador then
          endereco = {
            endereco_comprador:               self.logradouro,
            numero_endereco_comprador:        self.numero,
            bairro_endereco_comprador:        self.bairro,
            complemento_endereco_comprador:   self.complemento,
            cidade_endereco_comprador:        self.cidade,
            estado_endereco_comprador:        self.estado,
            cep_endereco_comprador:           self.cep,
          }
        when :endereco_entrega then
          endereco = {
            endereco_entrega:               self.logradouro,
            numero_endereco_entrega:        self.numero,
            bairro_endereco_entrega:        self.bairro,
            complemento_endereco_entrega:   self.complemento,
            cidade_endereco_entrega:        self.cidade,
            estado_endereco_entrega:        self.estado,
            cep_endereco_entrega:           self.cep,
          }
        else
          raise 'Endereço inválido.'
      end
      return endereco
    end

  end
end
