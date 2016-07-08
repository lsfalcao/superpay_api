# -*- encoding : utf-8 -*-
module SuperpayApi
  class Telefone

    MAPPING = {
      :outros                 => "Outros",
      :residencial            => "Residencial",
      :comercial              => "Comercial",
      :recados                => "Recados",
      :cobranca               => "Cobrança",
      :temporario             => "Temporário",
      :codigo_tipo_telefone   => "codigoTipoTelefone",
      :telefone               => "telefone",
      :ddd                    => "ddd",
      :ddi                    => "ddi",
    }

    # Opções de Tipo de Telefone
    TIPOS_DE_TELEFONE = {
      :outros        => 1,
      :residencial   => 2,
      :comercial     => 3,
      :recados       => 4,
      :cobranca      => 5,
      :temporario    => 6,
    }

    # Ver tabela “Tipos de Telefone”
    # Numérico - 1 dígito
    attr_accessor :codigo_tipo_telefone

    # Telefone sem espaços ou traços
    # Alfa Numérico - Até 10 caracteres
    attr_accessor :telefone

    # DDD do telefone
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddd

    # DDI do telefone
    # Alfa Numérico - Até 3 caracteres
    attr_accessor :ddi

    # Validações do Rails 3
    include ActiveModel::Validations

    # Retornar array com os possíveis tipos de telefone
    def self.validos
      TIPOS_DE_TELEFONE.map{ |key, value| key }
    end

    # Validações
    validates :codigo_tipo_telefone, inclusion: { in: SuperpayApi::Telefone.validos }, allow_nil: true
    validates :telefone, length: { maximum: 10 }
    validates :ddd, :ddi, length: { maximum: 3 }

  end
end
