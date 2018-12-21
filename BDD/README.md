# **Introdução**

Este diretório tem como objetivo testar e documentar o aplicativo por meio do uso 
de [BDD (Behavior-Driven-Development)](https://pt.wikipedia.org/wiki/Behavior_Driven_Development) para 
testes funcionais caixa-preta, com o intuito das features do BDD servirem também como uma documentação do aplicativo.

Os testes realizados testam o comportamento básico do sistema, não incluindo cenários mais complexos como Dynamic Type e Voice Over!

A estrutura do diretório está da seguinte maneira:  
```    
    features: arquivos de feature escritos seguindo a sintaxe Gherkin ficam na raiz do projeto
    *1.feature
    *2.feature
    *n.feature
    ├── config  
        ├── appium.txt: arquivo de configuração para rodar os testes no iOS  
        └── EasynvestSimulator.app: app a ser testado  
    ├── step_definitions  
        └── step_definitions_ios.rb: códigos em Ruby para testar o app iOS
    └── support 
        ├── hoooks.rb: arquivo que possui os métodos de SetUp e TearDown   
        └── env.rb: arquivo de configuração onde está o app a ser testado de acordo com o plataforma escolhida  
    cucumber.yml: arquivo de definição de profiles  
    README.md  
    .gitignore  
```

# **Primeiros Passos**
1. Pré-requisitos  
    Máquina com Mac OS, Xcode e Xcode Command Line Tools, para poder rodar os testes no **iOS**

2.	Ferramentas necessárias
    - Homebrew
        * Node.js
            * Appium
            * Appium-doctor
    - Appium_lib
    - Cucumber

# **Configuração de ambiente e Processos de instalação**
## 1. **Homebrew**
Para instalar o Homebrew:

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## 2. **Node.JS**
Para instalar o Node.js:
    
    brew install node

### 2.1. **Appium**
Instalando o Appium via terminal:
    
    npm install -g appium

### 2.2. **Appium-doctor**
Instalando o Appium-doctor:

    npm install -g appium-doctor

Após rodar o comando `appium-doctor`, caso seja necessário resolva os problemas apontados.

## 3. **Instalando o _Appium lib_**
    gem install appium_lib

## 4. **Instalando o _Cucumber_**
    gem install cucumber

# **Executando os testes**
Para rodar os testes, foi criado um perfil no arquivo `cucumber.yml`: **_ios_**.

1. Inicie o servidor **Appium** com o comando `appium` no terminal ou com o aplicativo desktop;
2. Inicie o simulador do **Xcode** para iOS;
3. Foi definido o seguinte _profile_:
    - **ios**: `mobile_env='ios' -r features/step_definitions -r features/support --format html --out report_ios.html --format pretty`
4. Para executar os testes usando um _profile_ específico para um plataforma:
    - `cucumber -p ios -t @tag` **_OU_**
    - **Tags** são opcionais, mas **muito úteis** para executar somente um conjunto de testes específicos!

# **Vale ressaltar que...**
Ainda é necessário, colocar as versões do aplicativo **iOS (.app)** dentro das pastas **`feature/config`** manualmente!
- Para conseguir o **.app** no **iOS**:
    - Navegue até a pasta **/Users/{SEU_NOME_DE_USUARIO}/Library/Developer/Xcode/DerivedData/<NOME_DO_APP>-<HASH_DE_BUILD>/Build/Products/Debug-iphonesimulator/<NOME_DO_APP>.app**
    - **<NOME_DO_APP>.app** é um diretório que deve ser copiado para o diretório **feature/config/ios** dentro deste projeto!
    - **O arquivo deve possuir a extensão .app, pois a versão .ipa não pode ser instalada no simulador!!**
- Para navegar até uma pasta no Finder do Mac use o atalho: `Command + Shift + G`
- **É importante lembrar, que toda vez que uma alteração nova for realizada no projeto, esses arquivos devem ser atualizados na pasta feature/config deste diretório!!**

# **Dicas valiosas!**
## **Inspetor de acessibilidade**
### iOS: Appium inspector
***Requer o aplicativo desktop do Appium!!** 
#### 1. Após iniciar o servidor Appium ele irá abrir um console, conforme mostrado na figura a seguir:  

![appium_inspector](http://www.automationtestinghub.com/images/appium/appium-desktop-server-started.png =500x200)  

#### 2. Ao selecionar o ícone de lupa no canto superior direito, ele irá abrir o inspetor, onde algumas configurações adicionais devem ser feitas, conforme mostrado na figura a seguir:  

![ios_inspector_configuration](features/config/ios_inspector_configuration.png =x400)

#### 3. Após definir as configurações, basta iniciar a sessão de inspeção selecionando o botão **Start Session** no canto inferior direito  

#### Para facilitar, segue o JSON utilizado na configuração:
***Lembre-se de trocar o nome de usuario pelo nome da sua máquina**  
``` json
{
  "deviceName": "iPhone 8 Plus",
  "platformName": "iOS",
  "app": "/Users/{CAMINHO_ATE_DIRETORIO}/BDD/features/config/EasynvestSimulator.app",
  "bundleId": "br.com.jgbrittos.EasynvestSimulator",
  "newCommandTimeout": 3600,
  "showXcodeLog": true,
  "platformVersion": "12.1"
}
```

### Comandos úteis
Abaixo estão listados alguns comandos e dicas que podem ser de grande ajuda na hora de criar, executar e manter os testes!
- `cucumber -t @tag`: executa todos os cenários marcados com a tag **@tag**;
- `cucumber -t @tag,@tag1`: executa todos os cenários marcados com a tag **@tag _OU_ @tag1**;
- `cucumber -t @tag -t @tag1`: executa todos os cenários marcados com as tags **@tag _E_ @tag1**;
- `# language pt`: Este comentário deve ser adicionado no início dos arquivos de funcionalidade para mudar a sintaxe Gherkin para português; 
- `cucumber.yml`: É o arquivo de configuração de _profiles_, que são como os _aliases_ do GIT, ou seja, chaves que guardam uma série de comandos e diretrizes de execução, desta forma, 
os comandos não precisam sempre serem digitados no momento da execução dos testes; 
    - Para executar um profile específico usamos o comando `cucumber -p <nome_profile>`
    - Pode ser concatenado com tags! 
    - `cucumber -p <qualquer_coisa>`: mostra todos os perfis criados no terminal;
- `--dry-run`: Serve apenas para vermos os steps de cada cenário, pois nenhum código dos steps_definitions será executado;
- Para não haver saidas no terminal e um **html** ser gerado na forma de um reporte de execução dos testes, os seguintes comandos podem ser adicionados aos perfis criados no arquivo `cucumber.yml`;
    - `--format <formato>`: especifica o formato que os resultados do teste devem ser mostrados, por exemplo, `--format html` exibirá os resultados na forma de **html**;
    - `--out <arquivo.formato>`: especifica o nome do arquivo que será gerado, com o formato especificado, em vez de mostrar os resultados no terminal, por exemplo, `--out report.html` irá 
criar um arquivo `report.html` na pasta raíz do projeto;
    - `--format pretty`: serve para também mostar os resultados no terminal, além de exportar o arquivo no formato desejado;
    - Pode ser necessário usar o comando `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer` para conseguir visualizar os conteúdos do simulador e copiar o diretório **.app**  

Links importantes e relacionados com este projeto:
- [Gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin)
