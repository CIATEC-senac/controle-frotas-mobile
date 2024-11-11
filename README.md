# AlfaID

Este é um projeto de aplicativo mobile desenvolvido com Flutter.

## Descrição

O AlfaID é um aplicativo móvel criado para monitorar rotas de fretados disponibilizados pela empresa a cerca de pegar os funcionários e deixa-los na empresa.

## Pré-requisitos

Certifique-se de que você possui o seguinte software instalado em sua máquina antes de iniciar:

- **Flutter SDK**: [Instruções de instalação](https://flutter.dev/docs/get-started/install)
- **Android Studio** (ou outro editor compatível, como VS Code): Usado para editar o código e rodar o emulador Android.
- **Xcode** (para desenvolvimento iOS, apenas em macOS): [Instruções de instalação do Xcode](https://developer.apple.com/xcode/).

## Passos para Configuração

### 1. Clonar o Repositório

Abra seu terminal e clone o repositório para sua máquina local:

```bash
git clone https://github.com/seu-usuario/alfaid.git
cd alfaid
```
### 2. Instalar Dependências

Após navegar para o diretório do projeto, instale as dependências do Flutter:

```bash
flutter pub get
```

### 3. Verificar o Ambiente de Desenvolvimento

Para garantir que o ambiente de desenvolvimento Flutter está configurado corretamente, execute o comando:

```bash
flutter doctor
```

Certifique-se de resolver quaisquer problemas apontados pelo ```flutter doctor``` antes de continuar.

### 4. Configurar um Emulador ou Dispositivo Físico

- **Android:** Abra o Android Studio, configure um emulador ou conecte um dispositivo físico com o modo de depuração USB ativado.

- **iOS:** Em um Mac, abra o Xcode, configure um simulador ou conecte um dispositivo físico com o modo de desenvolvimento ativado.

> **Nota:** Para testar no iOS, certifique-se de ter um dispositivo ou simulador configurado e que o Xcode esteja atualizado.

### 5. Executar o Projeto

Após configurar o emulador ou conectar um dispositivo, execute o projeto com o comando:

```bash
flutter run
```

## Comandos Úteis

- **Atualizar Dependências:** Execute ```flutter pub get``` sempre que adicionar novas dependências ao ```pubspec.yaml```.

- **Build para Produção:**
    - **Android:** ```flutter build apk```
    - **iOS:** ```flutter build ios``` (necessário Xcode configurado)

## Documentação e Recursos Adicionais

Para mais informações sobre o desenvolvimento com Flutter:

* [Documentação do Flutter](https://docs.flutter.dev/)
* [Lab: Escreva seu primeiro app em Flutter](https://docs.flutter.dev/get-started/codelab)
* [Cookbook: Exemplos úteis do Flutter](https://docs.flutter.dev/cookbook)