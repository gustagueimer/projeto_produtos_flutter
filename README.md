# Atividade 08 - Expansão de Navegação em Aplicação Flutter com Fake API

Uma aplicação desenvolvida seguindo os padrões do MVVM, separando o código em diferentes áreas de acordo com seu propósito. <br>
A Evolução atual consiste em adicionar uma tela inicial e uma tela de detalhes de produtos, utilizando do ``Navigator.push()`` e ``Navigator.pop()`` para alterar entre as telas.

## Questionario
**1. Qual era a estrutura do seu projeto antes da inclusão das novas telas?** <br>
*Estrutura do projeto antes:*
```
/lib 
|_/core
| |_/errors
| |_/network
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
      |_/states
      |_/pages
      |_/viewmodels
```
*Estrutura do projeto depois:*
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
``` 
<br>

**2. Como ficou o fluxo da aplicação após a implementação da navegação?** <br>
*A Aplicação inicia na tela inical, você aperta o botão ``Abrir tela de produtos`` para ir à tela de produtos, na tela de produtos você aperta no botão com o icone de download para
carregar a lista de produtos e no final você clica em um item da lista de produtos para abrir a tela de detalhes de produtos* <br>

**3. Qual é o papel do Navigator.push() no seu projeto?** <br>
*fazer a aplicação navegar (ie: trocar de) para outra tela* <br>

**4. Qual é o papel do Navigator.pop() no seu projeto?** <br>
*fazer a aplicação voltar para a tela anterior* <br>

**5. Como os dados do produto selecionado foram enviados para a tela de detalhes?** <br>
*via alteração do estado da tela de detalhes de produtos com o produto do card tocado na lista de produtos no viewmodel da tela de lista de produtos, antes de chamar o ``Navigator.push()``* <br>

**6. Por que a tela de detalhes depende das informações da tela anterior?** <br>
*a tela de detalhes de produtos precisa saber qual produto que foi selecionado na tela de lista de produtos para exibir os detalhes do produto selecionado* <br>

**7. Quais foram as principais mudanças feitas no projeto original?** <br>
*implementação de duas telas, seus states, providers e viewmodels, e adição de descrição a entidade e modelo de produto* <br>

**8. Quais dificuldades você encontrou durante a adaptação do projeto para múltiplas telas?** <br> 
*criar a UI das telas* <br>

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
git checkout Aula-8
```  
resolva as dependências com:
```
flutter pub get
```
e inicie a applicação com:
```
flutter run -d edge --web-browser-flag="--disable-web-security"
```
assim que a aplicação terminar de carregar no navegador, aperte no botão flutuante no canto inferior esquerdo e os produtos da API devem ser carregados na tela.