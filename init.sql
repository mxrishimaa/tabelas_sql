CREATE TABLE if not exists Alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo_a VARCHAR(255) NOT NULL,
    email_a VARCHAR(150) NOT NULL UNIQUE,
    data_nascimento_a DATE,
    telefone_a CHAR(15),
    data_cadastro_a DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE if not exists Professores (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo_p VARCHAR(255) NOT NULL,
    email_p VARCHAR(150) NOT NULL UNIQUE,
    data_nascimento_p DATE,
    telefone_p VARCHAR(15),
    especialidade VARCHAR(128)
);

CREATE TABLE if not exists Cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome_curso VARCHAR(80) NOT NULL,
    descricao VARCHAR(512),
    carga_horaria INT NOT NULL CHECK (carga_horaria >= 0),
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    professor_responsavel VARCHAR(255) NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE if not exists Matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT NOT NULL,
    curso_id INT NOT NULL,
    data_matricula DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    nota_final DECIMAL(4, 2),
    situacao ENUM(
        'CONCLUIDA',
        'EM_ANDAMENTO',
        'CANCELADA'
    ) DEFAULT 'EM_ANDAMENTO',

    CONSTRAINT chk_nota_final CHECK (nota_final BETWEEN 0 AND 10 OR nota_final IS NULL),
    CONSTRAINT uk_aluno_curso UNIQUE (aluno_id, curso_id),
    CONSTRAINT fk_matriculas_alunos FOREIGN KEY (aluno_id) REFERENCES Alunos(id_aluno),
    CONSTRAINT fk_matriculas_cursos FOREIGN KEY (curso_id) REFERENCES Cursos(id_curso)
);

