# -*- encoding : utf-8 -*-
module SuperpayApi
  module Utils

    # Map all the attributes from Utils.
    #
    MAPPING = {
      :autorizado_e_confirmado                => "Autorizado e Confirmado",
      :autorizado                             => "Autorizado",
      :nao_autorizado                         => "Não Autorizado",
      :transacao_em_andamento                 => "Transação em Andamento",
      :aguardando_pagamento                   => "Aguardando Pagamento",
      :falha_na_operadora                     => "Falha na Operadora",
      :cancelado                              => "Cancelado",
      :estornada                              => "Estornada",
      :em_analise_de_risco                    => "Em Análise de Risco",
      :recusado_analise_de_risco              => "Recusado Análise de Risco",
      :falha_no_envio_para_analise_de_risco   => "Falha no envio para Análise de Risco",
      :boleto_pago_a_menor                    => "Boleto Pago a menor",
      :boleto_pago_a_maior                    => "Boleto Pago a maior",
      :estorno_parcial                        => "Estorno Parcial",
      :estorno_nao_autorizado                 => "Estorno Não Autorizado",
      :operacao_em_andamento                  => "Operação em andamento",
      :transacao_ja_efetuada                  => "Transação já efetuada",
      :aguardando_cancelamento                => "Aguardando Cancelamento",
    }

    # Opções de Status das Transações
    STATUS = {
      1   => :autorizado_e_confirmado,
      2   => :autorizado,
      3   => :nao_autorizado,
      5   => :transacao_em_andamento,
      8   => :aguardando_pagamento,
      9   => :falha_na_operadora,
      13  => :cancelado,
      14  => :estornada,
      15  => :em_analise_de_risco,
      17  => :recusado_analise_de_risco,
      18  => :falha_no_envio_para_analise_de_risco,
      21  => :boleto_pago_a_menor,
      22  => :boleto_pago_a_maior,
      23  => :estorno_parcial,
      24  => :estorno_nao_autorizado,
      30  => :operacao_em_andamento,
      31  => :transacao_ja_efetuada,
      40  => :aguardando_cancelamento,
    }

  end
end

# validates :terms, acceptance: true
# validates :password, confirmation: true
# validates :username, exclusion: { in: %w(admin superuser) }
# validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
# validates :age, inclusion: { in: 0..9 }
# validates :first_name, length: { maximum: 30 }
# validates :age, numericality: true
# validates :username, presence: true
# validates :username, uniqueness: true
