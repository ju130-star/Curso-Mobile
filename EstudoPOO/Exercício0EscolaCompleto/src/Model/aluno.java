package Model;

public class aluno extends pessoa implements avaliavel {
    //atributos
    private String matricula;
    private double nota;
    //construtor
    public aluno(String nome, String cpf, String matricula, double nota) {
        super(nome, cpf);
        this.matricula = matricula;
        this.nota = nota;
    }
   //getters and setters
    public String getMatricula() {
        return matricula;
    }
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    public double getNota() {
        return nota;
    }
    public void setNota(double nota) {
        this.nota = nota;
    }
   //exibir informações  - Subescrita
   @Override
   public void exibirInformaçoes() {
    super.exibirInformaçoes();
    System.out.println("Matrícula: " + matricula);
    System.out.println("Nota: " + nota);
   }
@Override
public void avaliarDesempenho() {
    if (nota >=6.0) {
        System.out.println("Aluno aprovado.");
    }else {
        System.out.println("Aluno reprovado");
    }
    
   }
}
    