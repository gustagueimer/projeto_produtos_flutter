# Atividade 09 - CRUD em projeto

Uma aplicação desenvolvida seguindo os padrões do MVVM, separando o código em diferentes áreas de acordo com seu propósito. <br>
A Evolução atual consiste em adicionar uma tela de formulário para cadastro e edição de produtos, bem como a implementação de métodos de CRUD 
no repository e métodos no datasource que utilizem de get, post, put e delete para comunicar com a API.

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
| |_/utils
|_/features
  |_/product
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
git checkout Aula-9
```  
resolva as dependências com:
```
flutter pub get
```
e inicie a applicação com:
```
flutter run -d edge --web-browser-flag="--disable-web-security"
```
assim que a aplicação terminar de carregar no navegador, aperte no botão no centro inferior da tela para ir à tela de cadastro de produtos,
preencha os campos e aperte em criar produto para criar um produto e voltar à tela de produtos, aperte no botão flutuante no canto inferior 
esquerdo e os produtos da API devem ser carregados na tela (produtos criados manualmente, tanto anteirormente como posteriormente, irão para 
o fim da lista), aperte em um produto na lista para abrir a tela de detalhes, aperte no icone de lápis para abrir a tela de edição de produto,
mude os dados dos campos e aperte em salvar produto para voltar à tela anterior, aperte no ícone de lixeira para apagar o produto e retornar
à tela de produtos.