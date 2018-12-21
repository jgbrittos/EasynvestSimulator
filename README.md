# EasynvestSimulator
Easynvest iOS developer test
Este repositório contém o aplicativo desenvolvido para a prova da Easynvest.

## Sobre o aplicativo 
Seguindo as recomendações da prova algumas diretrizes foram obedecidas:
* _Landscape layout_: Não
* _iOS Target_: 11
* _Autolayout_: Sim
* _SwiftLint_: conforme o arquivo passado na descrição da prova, com apenas **uma modificação**:
	* A regra _**file_header**_ foi comentada
* _Plus_:
	* _Dynamic Type_: Sim
	* Acessibilidade: Voice Over
	* _URLSession_ e _Codable Protocol_: Sim
* Testes:
	* Unitário: 98% de cobertura
	* _BDD_: comportamentos básicos do sistema cobertos

## Arquitetura utilizada
A arquitetura utilizada foi a _VIP (Clean Swift)_, derivada da _Clean Architecture_.
Mais informações podem ser encontradas [neste link.](https://clean-swift.com)

## Testes unitários
Para os testes unitários foi utilizado o _framework_ nativo de testes **_XCTest_**.

## Testes caixa-preta automatizados
Além dos testes unitários, foram criados alguns testes de comportamento utilizando o _framework_ **_Cucumber_**

A pasta BDD/ contém além dos testes um arquivo README.md que serve como guia para entender os testes, configurar o ambiente e executar os testes criados.

Para fins de praticidade, o seguinte [vídeo](https://drive.google.com/open?id=1tSEotsZgXBI_VRb7ZzP74vD-ei4NmLb4) foi gravado para que não seja necessária a configuração de todo o ambiente para ver os testes executarem.
