package Controller;

import java.util.ArrayList;
import java.util.List;
import Model.aluno;
import Model.professor;

//método
public class Cursos {
    private String nomeCurso;
    private professor professor;
    private List<aluno> alunos;

    //construtor
    public Cursos(String nomeCurso, Model.professor professor, List<aluno> alunos) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        this.alunos = new ArrayList<>();
    }
    //adicionar alunos
    public void adicionarAluno(aluno aluno) {
        alunos.add(aluno);
    }
    //exibir informaçoes do curso
    public void exibirInformaçoesCurso() {
        System.out.println("Nome do Curso: " + nomeCurso);
        System.out.println("----------------------");
        System.out.println("Professor Responsável:" +professor.getNome());
        professor.exibirInformaçoes();
        System.out.println("----------------------");
        System.out.println("\nLista de Alunos:");
        int i =1;
        for (aluno aluno : alunos) {
        aluno.exibirInformaçoes();
        aluno.avaliarDesempenho();
        System.out.println("----------------------");
        }
    }
}

