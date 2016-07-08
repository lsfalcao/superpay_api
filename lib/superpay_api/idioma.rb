# -*- encoding : utf-8 -*-
module SuperpayApi
  class Idioma

    MAPPING = {
      :portugues    => "Português",
      :ingles       => "Inglês",
      :espanhol     => "Espanhol",
    }

    # Opções de idiomas
    IDIOMAS = {
      :portugues  => 1,
      :ingles     => 2,
      :espanhol   => 3,
    }
    # Retornar array com os possíveis idiomas
    def self.validos
      IDIOMAS.map{ |key, value| key }
    end

  end
end
