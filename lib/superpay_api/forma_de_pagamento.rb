# -*- encoding : utf-8 -*-
module SuperpayApi
  class FormaDePagamento

    # Opções de Formas de Pagamento
    FORMAS_DE_PAGAMENTO = {
      52   => "Cielo - Checkout Redirect",
      120  => "Cielo - Visa WebService",
      121  => "Cielo - MasterCard WebService",
      122  => "Cielo - American Express WebService",
      123  => "Cielo - ELO WebService",
      124  => "Cielo - Diners WebService",
      125  => "Cielo - Discover WebService",
      126  => "Cielo - Aura WebService",
      127  => "Cielo - JCB WebService",
      128  => "Cielo - Maestro WebService",
      129  => "Cielo - Visa Electron WebService",
      130  => "Cielo - Visa Redirect",
      131  => "Cielo - MasterCard Redirect",
      132  => "Cielo - American Express Redirect",
      133  => "Cielo - ELO Redirect",
      134  => "Cielo - Diners Redirect",
      135  => "Cielo - Discover Redirect",
      136  => "Cielo - Aura Redirect",
      137  => "Cielo - JCB Redirect",
      138  => "Cielo - Maestro Redirect",
      139  => "Cielo - Visa Electron Redirect",
      80   => "Rede - Visa Komerci Integrado Redirect",
      81   => "Rede - MasterCard Komerci Integrado Redirect",
      82   => "Rede - Diners Komerci Integrado Redirect",
      90   => "Rede - Visa Komerci WebService WebService",
      91   => "Rede - MasterCard Komerci WebService WebService",
      92   => "Rede - Diners Komerci WebService WebService",
      93   => "Rede - Hpercard Komerci WebService WebService",
      94   => "Rede - Hiper Komerci WebService WebService",
      204  => "Elavon - Visa WebService",
      205  => "Elavon - MasterCard WebService",
      206  => "Elavon - Diners WebService",
      207  => "Elavon - Discover WebService",
      270  => "GetNet - Visa WebService",
      271  => "GetNet - MasterCard WebService",
      350  => "Stone - Visa WebService",
      351  => "Stone - MasterCard WebService",
      380  => "Bin-FirstData - Visa WebService",
      381  => "Bin-FirstData - MasterCard WebService",
      382  => "Bin-FirstData - Cabal WebService",
      999  => "Múltiplos Cartões WebService",
    }

    # Retornar array com as possíveis Formas de Pagamento
    def self.validos
      FORMAS_DE_PAGAMENTO.map{ |key, value| key }
    end

  end
end
