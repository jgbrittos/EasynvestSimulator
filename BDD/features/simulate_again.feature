# language: pt
@simulate
Funcionalidade: Simular novamente um investimento
    Eu, como Usuário, 
    desejo refazer uma simulação de investimento
    para decidir qual investimento é melhor para mim
    
    Contexto: Dado que eu já fiz uma simulação anterior
        Dado que estou na tela de Formulário
        E digito "100000" no campo "investedAmount"
        E digito "10102020" no campo "maturityDate"
        E digito "125" no campo "rate"
        Quando aperto o botão "Simular"
        Então estou na tela de Detalhes da Simulação

    Cenário: Simular investimento novamente
        Quando aperto o botão "Simular novamente"
        Então estou na tela de Formulário