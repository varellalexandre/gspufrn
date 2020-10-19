# Projeto GSP3 UFRN

Projeto de gameficação do sequenciamento da linha de produção, foi desenvolvido em flutter para facilitar o acesso em qualquer local.

## Problema de sequenciamento

### Introdução
  O problema de sequenciamento das linhas de produção representa um importante tópico no aprendizado do arranjo físico por linha de produto. A principal característica deste arranjo é possuir uma sequência predefinida de atividades que coincide com a sequência em que os processos foram arranjados (SLACK; BRANDON-JONES;JOHNSTON, 2015). Este tipo de arranjo tem um amplo uso no sistema de produção em massa.
	Um dos métodos de solução ao problema é o COMSOAL(Computer Method of Sequencing Operations for Assembly Lines), definido por Arcus (1965) como um método de sequenciamento de operações para linhas de montagem utilizando de simulações de Monte-Carlo. 
Este método é caracterizado como uma heurística, e de acordo com Arcus (1965), utilizando um computador IBM 7090 e a linguagem FORTRAN foi mensurado um tempo de execução de 48 segundos para 1000 repetições em uma linha com 45 atividades. Embora o valor encontrado tenha sido um ótimo local ele apresenta um bom resultado para um computador com velocidade de leitura e escrita de 0,375 megabytes (IBM Data Processing Division, 1960), tendo em vista que hoje os computadores têm tecnologias e capacidades de processamento muito elevadas quando comparados com o 7090.
	O trabalho desenvolvido na tutoria envolve criar um programa que fomenta o aprendizado do sequenciamento de linha de produção, de forma interativa. Onde os alunos possam validar os conhecimentos adquiridos na disciplina e também aplicar o método COMSOAL em problemas reais.

### Materiais e Métodos
  Para desenvolvimento do programa de aprendizado do sequenciamento de linha de produção, foi considerado o público alvo do produto. Como a ideia é engajar de forma interativa os alunos, foi utilizado um framework mobile para desenvolvimento do programa. Esse framework permite uma adequação do site tanto para o ambiente de computador como para o ambiente mobile. Fato que reduz a necessidade de material para utilização do software.
	O framework escolhido foi flutter, que foi desenvolvido pelo google em 2018 e é baseado na linguagem Dart (Google Developers,2018). Recentemente, foi lançada a versão Web, que é a utilizada para desenvolvimento do software. É importante ressaltar que o framework utilizado embora seja desenvolvido pelo google, possui licença CC BY 4.0, que permite copiar e redistribuir o material, e adaptar o material para qualquer propósito. 
	Como explicado, o objetivo do programa é facilitar o aprendizado sobre o sequenciamento das linhas de produção, e para isso ele foi pensado na forma de um jogo, onde seriam adicionadas ou geradas as atividades da linha e cabe ao aluno as alocar no estágio mais adequado. Em seguida, ele poderia conferir se o sequenciamento realizado por ele está adequado. 
	Para verificar a adequação, o programa utilizaria o COMSOAL para encontrar uma solução satisfatória e compararia o valor da eficiência da linha respondida com o valor por ele encontrado. Além disso, existem outros eventos que são disparados antes deste cálculo.

### Resultados e Discussão
  Como definido o programa foi desenvolvido no framework Flutter, e hospedado na AWS temporariamente, posteriormente será transferido para o github para hospedagem por ofertar maior praticidade. Devido o formato de execução do programa ser interpretado pelo navegador, isso implica que o código é um arquivo estático o que retira a necessidade de um servidor para disponibilização do software, existindo possibilidades de hospedagem sem custo.
	Seguindo o fluxo apresentado nos métodos são apresentados a seguir o as telas para um exemplo simples de sequenciamento da linha de produção com o programa desenvolvido.
  
### Conclusão

  O software desenvolvido permite que os alunos da disciplina Gestão de Sistemas de Produção III aprendam de forma interativa o sequenciamento das atividades do arranjo físico de linha. Além disso é possível utilizar o software de forma gratuita para validar o sequenciamento em empresas reais.
  Cabe ressaltar que o software pode ser aprimorado para gerar exemplos aleatórios, além de otimizações no cálculo por meio de pesos como Arcus (1965) apresenta em seu artigo.

### Referências

SLACK, Nigel; BRANDON-JONES, Alistair; JOHNSTON, Robert. Administração da Produção. 4. ed. São Paulo: Editora Atlas S.A., 2015. 720 p.

ARCUS, ALBERT L. A COMPUTER METHOD OF SEQUENCING OPERATIONS FOR ASSEMBLY LINES. International Journal of Production Research, v. 4:4, p. 259-277, 1965.

7090 Data Processing System. IBM Data Processing Division, 4 out. 1960. Disponível em: https://www.ibm.com/ibm/history/exhibits/mainframe/mainframe_PP7090.html. Acesso em: 10 out. 2020.

Flutter Release Preview 2. Google Developers, 19 set. 2018 . Disponível em: https://www.youtube.com/watch?v=_LfjILXswJs&list=PLOU2XLYxmsIJ7dsVN4iRuA7BT8XHzGtCr&index=6. Acesso em: 10 out. 2020.


