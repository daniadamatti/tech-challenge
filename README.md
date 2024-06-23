# Desafio técnico e-commerce

## Nossas expectativas

A equipe de engenharia da RD Station tem alguns princípios onde baseamos nosso trabalho diário. Um deles é: projete seu código para ser mais fácil de entender, não mais fácil de escrever.

Portanto, para nós é mais importante um código de fácil leitura do que um que utilize recursos complexos e/ou desnecessários.

O que gostariamos de ver:

- O código deve ser fácil de ler. Clean Code pode te ajudar
- Notas gerais e informações sobre a versão da linguagem e outras informações importantes para executar seu código.
- Código que se preocupa com a performance (Complexidade de Algoritmo)
- O seu código deve cobrir todo os casos de usos presentes no README, mesmo que não haja um teste implementado para tal.
- A adição de novos testes é sempre bem-vinda
- Você deve enviar para nós um arquivo zip contendo o código-fonte da solução e as instruções para rodá-lo ou pode fazer o upload da solução para repositórios públicos (GitHub, BitBucket, etc) e nos enviar o link de acesso.

## O Desafio - Carrinho de compras
O desafio consiste em uma API para gerenciamento do um carrinho de compras de e-commerce.

Você deve desenvolver utilizando a linguagem Ruby e framework Rails, uma API Rest que terá 3 endpoins que deverão implementar as seguintes funcionalidades:

### 1. Registrar um produto no carrinho
Criar um endpoint para inserção de produtos no carrinho.

Se não existir um carrinho para a seção, criar o carrinho.

Adicionar o produto no carrinho e devolver o payload com a lista de produtos do carrinho atual.

POST: `/cart`
Payload:
```js
{
  "product_id": 345, // id do produto sendo adicionado
  "quantity": 2, // quantidade de produto a ser adicionado
}
```

Response
```js
{
  "id": 789, // id do carrinho
  "products": [
    {
      "id": 645,
      "name": "Nome do produto",
      "quantity": 2,
      "unit_price": 1.99, // valor unitário do produto
      "total_price": 3.98, // valor total do produto
    },
    {
      "id": 646,
      "name": "Nome do produto 2",
      "quantity": 2,
      "unit_price": 1.99,
      "total_price": 3.98,
    },
  ],
  "total_price": 7.96 // valor total no carrinho
}
```

### 2. Listar itens do carrinho atual
Criar um endpoint para listar os produtos no carrinho atual.

GET: `/cart`

Reponse:
```js
{
  "id": 789, // id do carrinho
  "products": [
    {
      "id": 645,
      "name": "Nome do produto",
      "quantity": 2,
      "unit_price": 1.99, // valor unitário do produto
      "total_price": 3.98, // valor total do produto
    },
    {
      "id": 646,
      "name": "Nome do produto 2",
      "quantity": 2,
      "unit_price": 1.99,
      "total_price": 3.98,
    },
  ],
  "total_price": 7.96 // valor total no carrinho
}
```

### 3. Excluir carrinhos abandonados
Um carrinho é considerado abandonado quando ele estiver sem interação (adição ou remoção de produtos) há mais de 3 horas.

- Quando esse cenário acontecer o carrinho deve ser marcado como abandonado
- Ao marcar esse carrinho como abandonado inserir um registro em uma tabela de notificação
- Se o carrinho estiver abandonado a mais de 7 dias remover o carrinho

### Como resolver
Você deve usar como base o código disponível desse repositório e expandi-lo para que atenda as funcionalidade descritas acima.

Há trechos parcialmente implementados e também sugestões de locais para algumas das funcionalidades sinalizados com um `# TODO`. Você pode segui-los ou fazer da maneira que julgar ser a melhor a ser feita, desde que atenda os contratos de API e funcionalidades descritas.

Há testes passando, pendentes e com erro. Com a sua implementações os testes pendentes devem ser implementados e os com erro devem passar a funcionar. A adição de novos testes é sempre bem-vinda, mas sem alterar os já implementados.

## Informações técnicas

### Dependências
- ruby 3.3.1
- rails 7.1.3.2
- postgres 16
- redis 7.0.15

### Como executar o projeto
Dado que todas as as ferrametas estão instaladas e configuradas:

Instalar as dependências do:
```bash
bundle install
```

Executar o sidekiq:
```bash
bundle exec sidekiq
```

Executar projeto:
```bash
bundle exec rails server
```

Executar os testes:
```bash
bundle exec rspec
```
