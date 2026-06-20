# Atividade 12 - Alteração da API para o DummyJson e implementação tela e funcionalidaade de Login

Uma aplicação desenvolvida seguindo os padrões do MVVM, separando o código em diferentes áreas de acordo com seu propósito. <br>
A Evolução atual consiste em trocar a API de produtos para o DummyJson e realizar adequações na entidade e no modelo para que o app funcione igualmente à API anterior,
também consta na evolução a implementação de entidades de usuário e login, salvamento de dados relacionados a sessão em cache, uma tela inicial de Login, métodos para
validar sessões existentes, dentre outros.

## Estrutura autal do código do projeto:

```
/lib 
|_/core
| |_/errors
| |_/network
| |_/presentation
| | |_/pages
| | |_/states
| | |_/viewmodels
| | |_/widgets
| |_/utils
|_/features
  |_/product
  | |_/data
  | | |_/datasources
  | | |_/models
  | | |_/repositories
  | |_/domain
  | | |_/entities
  | | |_/repositories
  | |_/presentation
  |   |_/pages
  |   |_/states
  |   |_/viewmodels
  |   |_/widgets
  |_/user
    |_/data
    | |_/datasources
    | |_/models
    | |_/repositories
    |_/domain
    | |_/entities
    | |_/repositories
    |_/presentation
      |_/pages
      |_/states
      |_/viewmodels
      |_/widgets
```

## Como Rodar

### Requisitos 
`` Flutter 3.35.3 `` <br>
`` Dart 3.9.2 `` <br>

Clone este repositório em um folder de seu dispositivo seguindo os segiuntes passosem um terminal: <br>
```
git clone https://github.com/gustagueimer/projeto_produtos_flutter
``` 
entre na pasta pelo terminal com: 
```
cd projeto_produtos_flutter
```
troque para a branch da atividade com:
``` 
git checkout Aula-12
```  
resolva as dependências com:
```
flutter pub get
```
e inicie a applicação com:
```
flutter run -d edge --web-browser-flag="--disable-web-security"
```
assim que a aplicação terminar de carregar no navegador, insira no campo ``username`` o seguinte valor:
```
emilys
```
e no campo ```senha``` o seguinte valor:
```
emilyspass
```
após a realização do login, é possóvel recarregar a página (ou dar um hot reload no console) para conferir se ele esta buscando as 
informações de logins salvas no cache e está pulando diretamente para a tela de produtos. na tela de produtos, opicionalmente aperte em ``encerrar sessão``
no footer bar para encerrar a sessão e voltar a tela de login, a seguir, opicionalmente aperte em ``criar novo produto`` para ir a tela de formulário de 
produto, a seguir, preencha os campos e aperte em criar produto para criar um produto e voltar à tela de produtos, aperte no botão flutuante no canto 
inferior esquerdo e os produtos da API devem ser carregados na tela (produtos criados manualmente, tanto anteirormente como posteriormente, irão para 
o fim da lista), aperte em um produto na lista para abrir a tela de detalhes, aperte no icone de lápis para abrir a tela de edição de produto,
mude os dados dos campos e aperte em salvar produto para voltar à tela anterior, aperte no ícone de lixeira para apagar o produto e retornar
à tela de produtos.
