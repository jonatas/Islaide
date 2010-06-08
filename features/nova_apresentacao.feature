# language: pt
Funcionalidade: Criar uma nova apresentação
  Como um palestrante
  Eu quero criar uma nova apresentação
  Pois vou mostrar as novidades da web 2.0

  @javascript
  Cenário: Criar uma nova apresentação
    Dado que estou na página de nova apresentação
    E que preenchi "Novidades da WEB 2.0" no campo "title"
    E que preenchi "Jonatas Paganini" no campo "author"
    E que preenchi "jonatasdp@gmail.com" no campo "email"
    E que preenchi "secret" no campo "password"
    Quando eu pressionar "Iniciar apresentação"

    Então devo ver "Jonatas Paganini"

    Dado que inseri os seguintes dados
    """
    * HTML 5
    * Javascript
    * CSS 3D
    * WEBGL
    ==
    \# HTML 5
    \##> _Em busca de uma internet mais desktop_
    * Banco de dados SQLite
    * Compatibilidade com mobile
    $ alert('ola')
    * Meta tags
    """
   




