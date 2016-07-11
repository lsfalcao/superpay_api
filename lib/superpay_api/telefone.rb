# -*- encoding : utf-8 -*-
module SuperpayApi
  class Telefone

    MAPPING = {
      :outros       => "Outros",
      :residencial  => "Residencial",
      :comercial    => "Comercial",
      :recados      => "Recados",
      :cobranca     => "Cobrança",
      :temporario   => "Temporário",
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

    # Nova instancia da classe Telefone
    # @param [Hash] campos
    def initialize(campos = {})
      campos.each do |campo, valor|
         if SuperpayApi::Telefone.public_instance_methods.include? "#{campo}=".to_sym
          send "#{campo}=", valor
        end
      end
    end

    # Retornar o número do tipo de telefone
    def codigo_tipo_telefone_to_request
      TIPOS_DE_TELEFONE[self.codigo_tipo_telefone]
    end

    # Montar o Hash de tefone conforme o tipo dele
    def to_request tipo
      telefone = {}
      case tipo.to_sym
        when :comprador then
          telefone = {
            codigo_tipo_telefone_comprador:   self.codigo_tipo_telefone_to_request,
            telefone_comprador:               self.telefone,
            ddd_comprador:                    self.ddd,
            ddi_comprador:                    self.ddi,
          }
        when :adicional_comprador then
          telefone = {
            codigo_tipo_telefone_adicional_comprador:   self.codigo_tipo_telefone_to_request,
            telefone_adicional_comprador:               self.telefone,
            ddd_adicional_comprador:                    self.ddd,
            ddi_adicional_comprador:                    self.ddi,
          }
        when :entrega then
          telefone = {
            codigo_tipo_telefone_entrega:   self.codigo_tipo_telefone_to_request,
            telefone_entrega:               self.telefone,
            ddd_entrega:                    self.ddd,
            ddi_entrega:                    self.ddi,
          }
        when :adicional_entrega then
          telefone = {
            codigo_tipo_telefone_adicional_entrega:   self.codigo_tipo_telefone_to_request,
            telefone_adicional_entrega:               self.telefone,
            ddd_adicional_entrega:                    self.ddd,
            ddi_adicional_entrega:                    self.ddi,
          }
        else
          raise 'Tipo inválido.'
      end
      return telefone
    end

  end
end
