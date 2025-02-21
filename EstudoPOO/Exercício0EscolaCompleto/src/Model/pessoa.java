package Model;

public abstract class pessoa {
    //atributos privados (encapsulamento)
    private String nome;
    private String cpf;

//contrutor
public pessoa(String nome, String cpf) {
    this.nome = nome;
    this.cpf = cpf;
}

//getters and setters
public String getNome() {
    return nome;
}

public void setNome(String nome) {
    this.nome = nome;
}

public String getCpf() {
    return cpf;
}

public void setCpf(String cpf) {
    this.cpf = cpf;
}

//Métodos exibir informação
public void exibirInformaçoes() {
    System.out.println("Nome: "+ nome);
    System.out.println("CPF" + cpf);
}}


