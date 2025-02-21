package Model;

public class professor  extends pessoa {
    private double salario;

    public professor(String nome, String cpf, double salario) {
        super(nome, cpf);
        this.salario = salario;
    }
    public double getSalario() {
        return salario;
    }
    public void setSalario(double salario) {
        this.salario = salario;
    }
    
    @Override
    public void exibirInformaçoes() {
        super.exibirInformaçoes();
        System.out.println("Saário: R$ " + salario);
    }
}
