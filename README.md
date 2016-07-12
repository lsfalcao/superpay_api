# SuperPay API - Gateway de pagamento

## Versão Beta

Gem para utilização do SuperPay API disponibilizado pela empresa [SuperPay](http://superpay.locaweb.com.br/) para integrar sua plataforma de forma segura e eficaz com as principais formas de pagamento disponíveis no mercado.

A biblioteca SuperPayAPI em Ruby é um conjunto de classes de domínio que facilitam, para o desenvolvedor Ruby, a utilização das funcionalidades que o SuperPay oferece na forma de [APIs](http://wiki.superpay.com.br/wikiSuperPay/index.php/P%C3%A1gina_principal). Com a biblioteca instalada e configurada, você pode facilmente integrar funcionalidades como:

 - [Criar transação]
 - [Consultar transação]
 - [Capturar transação] \(Em desenvolvimento\)
 - [Cancelar transação] \(Em desenvolvimento\)
 - [Estorno de transação] \(Em desenvolvimento\)
 - [Campainha] \(Em desenvolvimento\)
 - [Múltiplos Cartões] \(Em desenvolvimento\)
 - [One Click] \(Em desenvolvimento\)
 - [Cobrança Recorrente] \(Em desenvolvimento\)

## Instalando

### Gemfile

Adicione esta linha ao Gemfile do seu aplicativo:

```ruby
  gem 'superpay_api'
```

 - Execute o comando `bundle install`.

### Instalação direta

```ruby
  $ gem install superpay_api
```

## Configuração

Para fazer a autenticação, você precisará configurar as credenciais do SuperPay. Crie o arquivo `config/initializers/superpay_api.rb` com o conteúdo abaixo.

```ruby
SuperpayApi.configure do |config|

  #
  # Código que identifica o estabelecimento dentro do SuperPay
  # Enviado pelo SuperPay
  config.estabelecimento = "1010101010101010"

  #
  # Código que identifica o usuario dentro do SuperPay
  # Enviado pelo SuperPay
  config.usuario = "superpay"

  #
  # Código que identifica a senha dentro do SuperPay
  # Enviado pelo SuperPay
  config.senha = "superpay"

  #
  # Opções de ambiente
  # [:homologacao, :producao]
  config.ambiente = :producao

  #
  # URL será sempre acionada quando o status do pedido mudar.
  # Deve estar preparada para receber dados de campainha
  config.url_campainha = 'http://localhost:3000'

  #
  # Opções de idiomas
  # [:portugues, :ingles, :espanhol]
  config.idioma = :portugues

  #
  # Opções de Origem da Transação
  # Consulte área de suporte sobre a habilitação das origens
  # [:ecommerce, :mobile, :ura, :pos]
  config.origem_transacao = :ecommerce
end
```

## Criar transação

A principal funcionalidade do SuperPay. Envia a transação e realiza o pagamento com base na mesma. Uma das características mais importantes desse processo é uma conferência realizada pelo SuperPay na operadora antes de enviar a transação.

Antes do envio da transação para as operadoras e instituições financeiras, o gateway de pagamento realiza uma pequena conferência na mesma para se certificar que não existe nenhuma transação com o mesmo número de pedido para aquele estabelecimento.

O número do pedido é um valor enviado pelo próprio estabelecimento, portanto é importante que o mesmo se certifique que tais valores sejam únicos para cada transação. Caso essa consulta prévia do gateway identifique na operadora uma transação já enviada a nova transação com o mesmo número de pedido pode resultar em falha.

Para iniciar uma requisição de pagamento, você precisa instanciar a classe `SuperpayApi::Transacao`. Isso normalmente será feito em seu controller de checkout.

A classe `SuperpayApi::Transacao` é montada com outras classes \(`SuperpayApi::DadosUsuario`, `SuperpayApi::Endereco`, `SuperpayApi::Telefone`, `SuperpayApi::ItemPedido`\) com suas devidas validações.

O retorno será um objeto da classe `SuperpayApi::Retorno` \(Verifique o objeto mais abaixo\).

### Montar Transação

```ruby
transacao = SuperpayApi::Transacao.new ({
  numero_transacao:               "1",
  ip:                             "127.0.0.1",
  codigo_forma_pagamento:         120,
  valor:                          "28260",
  valor_desconto:                 "0",
  taxa_embarque:                  "0",
  parcelas:                       "1",
  nome_titular_cartao_credito:    "Visa",
  numero_cartao_credito:          "4444333322221111",
  codigo_seguranca:               "123",
  data_validade_cartao:           "12/2017",
  # vencimento_boleto:              self.vencimento_boleto,
  # url_redirecionamento_pago:      self.url_redirecionamento_pago,
  # url_redirecionamento_nao_pago:  self.url_redirecionamento_nao_pago,
  # campo_livre1:                   self.campo_livre1,
  # campo_livre2:                   self.campo_livre2,
  # campo_livre3:                   self.campo_livre3,
  # campo_livre4:                   self.campo_livre4,
  # campo_livre5:                   self.campo_livre5,
  # dados_usuario_transacao:          dados_usuario,
  # itens_do_pedido:                  [item_pedido_1, item_pedido_2],
})

# Após montar o objeto e verificar as validações, chame a função enviar_pagamento
retorno = transacao.enviar_pagamento if transacao.valid?
```

### Montar Itens do Pedido

```ruby
item_pedido_1 = SuperpayApi::ItemPedido.new ({
  codigo_produto:           "11",
  nome_produto:             "Item Pedido 1",
  quantidade_produto:       "2",
  valor_unitario_produto:   "12312",
  codigo_categoria:         "1",
  nome_categoria:           "Itens de Pedidos",
})

item_pedido_2 = SuperpayApi::ItemPedido.new ({
  codigo_produto:           "12",
  nome_produto:             "Item Pedido 2",
  quantidade_produto:       "3",
  valor_unitario_produto:   "1212",
  codigo_categoria:         "1",
  nome_categoria:           "Itens de Pedidos",
})
```

### Montar Dados do Usuário

```ruby
dados_usuario = SuperpayApi::DadosUsuario.new ({
  codigo_cliente:                 1,
  tipo_cliente:                   :pessoa_fisica,
  nome:                           "Leandro Falcão",
  documento:                      "999.999.999-9",
  documento_2:                    "99.999.999-9",
  sexo:                           :masculino,
  data_nascimento:                "01/01/1980",
  email:                          "contato@qw3.com.br",
  endereco_comprador:             endereco,
  endereco_entrega:               endereco,
  telefone_comprador:             telefone,
  # telefone_adicional_comprador:  telefone,
  telefone_entrega:               telefone,
  # telefone_adicional_entrega:    telefone,
})
```

### Montar Endereço

```ruby
endereco = SuperpayApi::Endereco.new ({
  logradouro:    "Rua Dom Pedro II",
  numero:        "1330",
  bairro:        "Vila Monteiro (Gleba I)",
  complemento:   "Sala A",
  cidade:        "São Carlos",
  estado:        "SP",
  cep:           "13560-320",
})
```

### Montar Telefone

```ruby
telefone = SuperpayApi::Telefone.new ({
  codigo_tipo_telefone:   :comercial,
  telefone:               "3416-6404",
  ddd:                    "16",
  ddi:                    "+55",
})
```

## Consultar transação

Para consultar uma transação basta chamar função `SuperpayApi::Transacao.consulta_transacao(numero_transacao)`, será retorno um objeto do tipo `SuperpayApi::Retorno`.

```ruby
retorno = SuperpayApi::Transacao.consulta_transacao(numero_transacao)
```

## Exemplo de Retorno

```ruby
retorno = {
  :numero_transacao             => '1',
  :codigo_estabelecimento       => '1010101010101010',
  :codigo_forma_pagamento       => '120',
  :valor                        => '28260',
  :valor_desconto               => '0',
  :taxa_embarque                => '0',
  :parcelas                     => '1',
  :url_pagamento                => '14132971582229c00506d-e84d-4526-b902-92190d5aa808',
  :status_transacao             => '1',
  :autorizacao                  => '******',
  :codigo_transacao_operadora   => '0',
  :data_aprovacao_operadora     => '20/01/2016',
  :numero_comprovante_venda     => '1006993069181F841001',
  :mensagem_venda               => 'Transacao capturada com sucesso',
}

## Autor
- [QW3 Software & Marketing](http://qw3.com.br)
- [Leandro dos Santos Falcão](https://www.linkedin.com/in/lsfalcao)

## Copyright

[QW3 Software & Marketing](http://qw3.com.br)

![QW3 Logo](http://qw3.com.br/qw3_logo.png)

The MIT License (MIT)

Copyright (c) 2015 QW3

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


  [Criar transação]: http://wiki.superpay.com.br/wikiSuperPay/index.php/Criar_transa%C3%A7%C3%A3o_SOAP
  [Consultar transação]: http://wiki.superpay.com.br/wikiSuperPay/index.php/Consultar_transa%C3%A7%C3%A3o_SOAP
  [Capturar transação]: http://wiki.superpay.com.br/wikiSuperPay/index.php/Capturar_transa%C3%A7%C3%A3o_SOAP
  [Cancelar transação]: http://wiki.superpay.com.br/wikiSuperPay/index.php/Cancelar_transa%C3%A7%C3%A3o_SOAP
  [Estorno de transação]: http://wiki.superpay.com.br/wikiSuperPay/index.php/Estorno_de_transa%C3%A7%C3%A3o_SOAP
  [Campainha]: http://wiki.superpay.com.br/wikiSuperPay/index.php/Campainha
  [Múltiplos Cartões]: http://wiki.superpay.com.br/wikiSuperPay/index.php/M%C3%BAltiplos_Cart%C3%B5es
  [One Click]: http://wiki.superpay.com.br/wikiSuperPay/index.php/One_Click
  [Cobrança Recorrente]: http://wiki.superpay.com.br/wikiSuperPay/index.php/Cobran%C3%A7a_Recorrente
