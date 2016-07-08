# -*- encoding : utf-8 -*-
module SuperpayApi
  class Endereco

    MAPPING = {
      :logradouro    => "endereco",
      :numero        => "numeroEndereco",
      :bairro        => "bairroEndereco",
      :complemento   => "complementoEndereco",
      :cidade        => "cidadeEndereco",
      :estado        => "estadoEndereco",
      :cep           => "cepEndereco",
    }

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

  end
end

