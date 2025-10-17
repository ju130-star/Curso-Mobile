# SA PontoGeo — Aplicativo de Registro de Ponto com Geolocalização e Firebase

---
##  Descrição do Projeto

O **PontoGeo** é um aplicativo mobile desenvolvido em **Flutter** para **registro de ponto eletrônico**, que utiliza **autenticação Firebase** e **geolocalização** para validar a localização do funcionário no momento do registro.

O sistema permite que o usuário:
- Faça **login ou cadastro** usando o Firebase Authentication.  
- Registre o ponto **somente quando estiver a até 100 metros do local de trabalho**.  
- Armazene as informações (data, hora e localização) em **tempo real** no **Firebase Firestore**.  
- Visualize o **histórico completo de registros** com data e hora.

---

##  Objetivos do Projeto

- Aplicar na prática o uso do **Flutter** com **Firebase** e **APIs externas (Geolocator)**.  
- Demonstrar o uso de **autenticação segura**, **verificação de localização**, **data e hora** e **armazenamento em nuvem**.  
- Implementar boas práticas de **organização de código**, **UI/UX** e **documentação**.  

---

##  Funcionalidades Principais

### Autenticação
- Login e cadastro via **Firebase Authentication** (e-mail e senha).  
- Identificação única de cada usuário com **UID** gerado pelo Firebase.  

###  Registro de Ponto (Geolocalização)
- Captura automática da **latitude e longitude** do usuário com o pacote `geolocator`.  
- Mede a distância até o ponto fixo da empresa com:
  ```dart
  Geolocator.distanceBetween(latUser, lngUser, latEmpresa, lngEmpresa);

---

## Armazenamento de Data e Hora

 - Utiliza DateTime.now() para registrar o horário exato do ponto.

 - O pacote intl formata a data/hora para exibição.

## Tecnologias Utilizadas
- Flutter
- Firebase Authentication
- Cloud Firestore
- Geolocator / Geocoding
- Intl

## Fluxo de Uso do App
- Login/Cadastro: o usuário cria uma conta ou entra no sistema.

- Tela Principal: mostra o botão “Registrar Ponto”.

- Verificação de Localização: o app mede a distância até o ponto fixo da empresa.

- Registro de Ponto: se dentro do raio permitido, salva data, hora e coordenadas no Firestore.

- Histórico: o usuário visualiza todos os registros com data/hora.

## Explicação Técnica
 ### Autenticação (Firebase)
- O FirebaseAuth faz o controle de login e registro de novos usuários.

- O Firebase gera um UID único para cada conta.

- Após o login, o usuário é autenticado para registrar pontos.

### Geolocalização (Geolocator)
- A API do Geolocator usa o GPS do dispositivo para capturar as coordenadas.

- A distância é calculada usando distanceBetween() com as coordenadas do usuário e da empresa.

- Se estiver a menos de 100 metros, o ponto é autorizado e salvo.

### Data e Hora

- DateTime.now() captura o horário exato.

- intl formata para exibição legível no histórico.

### Firebase Firestore

- O Firestore salva cada registro em tempo real.

- A consulta usa StreamBuilder, atualizando automaticamente a lista de registros na tela.