# language: pt
@form
Funcionalidade: Formulário para simulação de investimentos
    Eu, como Usuário, 
    desejo fazer uma simulação de investimento
    para decidir qual investimento é melhor para mim
    
    Esquema do Cenário: Tentar fazer simulação com dados incorretos
        Dado que estou na tela de Formulário
        E digito "<investimento>" no campo "investedAmount"
        E digito "<data>" no campo "maturityDate"
        E digito "<taxa>" no campo "rate"
        Quando aperto o botão "Simular"
        Então um alerta deve aparecer mostrando a seguinte "<mensagem>"

        Exemplos:
        |investimento|data    |taxa|mensagem                                                            |
        |            |10102020|100 |Algum problema ocorreu com a total a ser investido. Tente novamente!|
        |100000      |101020  |100 |Algo ocorreu durante a requisição                                   |
        |100000      |10102018|100 |Algo ocorreu durante a requisição                                   |
        |100000      |        |100 |Algum problema ocorreu com a data. Tente novamente!                 |
        |100000      |10102020|    |Algum problema ocorreu com o percentual do papel. Tente novamente!  |
    
    Cenário: Tentar fazer simulação com dados corretos
        Dado que estou na tela de Formulário
        E digito "100000" no campo "investedAmount"
        E digito "10102020" no campo "maturityDate"
        E digito "125" no campo "rate"
        Quando aperto o botão "Simular"
        Então estou na tela de Detalhes da Simulação