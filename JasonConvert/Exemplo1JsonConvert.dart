import 'dart:convert';

void main(){
  //String no Formato Json
  String jsonString ='''{
                         "usuario": "João", 
                         "login": "joao_user", 
                         "senha":1234,
                         "ativo":true
                         }''';

//converte a String em Map -> usando Json Convert (decode)
Map<String, dynamic> usuario = json.decode(jsonString);

//acesso aos elementos (atributos) do Json
print(usuario["ativo"]);

// fazer o encode Map => Json(texto)
  jsonString = json.encode(usuario);

  // mostrar o texto no formato JSON
  print(jsonString);
  
}// Exemplo de uso do JsonConvert para manipulação de dados JSON em Dart


