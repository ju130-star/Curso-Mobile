# CineFavorite (Formativa)

## Briefing
Construir um Aplicativo do Zero - O CineFavorite que permitirá criar uma conte e buscar filmes em uma API, montar uma galeria pessoal de filmes favoritos, com poster(capa) e nota avaliativa do usuário para o filme.

## Objetivos
- Criar uma Galeria Personalizada por Usuário de Filmes Favoritos
- Buscar Filmes em uma API e Listar para selecionar filmes favoritos
- Criação de Contas por Usuário
- Listar filmes por palavra-chave

## Levantamento de Requisitos
- ### Funcionais
- ### Não Funcionais

## Recursos do Projeto
- Linguagem de programação: Flutter/Dart
- API TMDB: Base de dados para Filmes
- Figma: Prototipagem
- GitHub: Para Armazenamento e Versionamento do Código
- FireBase: Authentication/ FireStore DB
- VsCode: Codificação / Teste 

## Diagramas
1. ### Classe:
Demostrar o Funcionamento Das Entidades do Sistema
- Usuário (User): Classe já modelada pelo FireBaseAuth
      - Atributos: email, senha, uid
      - Métodos: login, registrar, logout
- Filmes Fvaoritos (Movie): Classe Modelada pelo DEV - Baseada na API TMDB
     - Atributos: id, título, PosterPath, Nota
     - Métodos: adicionar, remover, listar, atualizarNota (CRUD)

```mermaid

classDiagram

    class User{
        +String uid,
        +String email,
        +String password,
        +login()
        +logout()
        +register()
    }

    class Movie{
        +int id
        +String title
        +String posterPath
        +double rating
        +addFavorite()
        +removeFavorite()
        +updateMovieRathing()
        +getFavoriteMovie()
    }
    User "1"--"1+" Movie : "select"
```
2. ### Uso
Ação que os Atores Podem Fazer
- Usuário:
      - Registrar
      - Login
      - Logout
      - Procurar Filmes na API
      - Salvar Filmes aos Favoritos
      - Dar Nota aos Filmes Favoritos
      - Remove Filmes dos Favoritos

```mermaid

graph TD
   subgraph "Ações"~
     ac1([Registrar])
     ac2([Login])
     ac3([Logout])
     ac4([SearchMovies])
     ac5([AddFavoriteMovies])
     ac6([UpdateMovieRsating])
     ac7([RemoveFavoriteMovie])
  end

  user([Usuário])

  user --> ac1   
  user --> ac2

  ac1 --> ac2   
  ac2 --> ac3   
  ac2 --> ac4   
  ac2 --> ac4   
  ac2 --> ac6   
  ac2 --> ac7   

```

3. ### Fluxo
Determinar o Caminhp Percorrido pelo Ator Para Executar uma Ação

- Fluxo de Ação de Login

```mermaid

    A[Início] --> B{Tela de Login}
    B --> C[Inserir Email e Senha]
    C --> D{Validar as Credenciais}
    D --> Sim --> G[Favorite View]
    D --> Não --> B

```

## Protopipagem

Link dos Protótipos: https://www.figma.com/design/NeCrbzn9ToTkVg3M8OYx0h/Untitled?node-id=2-13&t=KMsLqmQ6IGgZW3uf-1
