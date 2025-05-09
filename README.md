# Controle de frotas

## Descrição

Aplicativo android desenvolvido com flutter para fazer o controle de frotas realizadas pelo motorista e também a aprovação das rotas pelo responsável.

## Pré-requisitos

Certifique-se de que você possui o seguinte software instalado em sua máquina antes de iniciar:

- **Flutter SDK**: [Instruções de instalação](https://flutter.dev/docs/get-started/install)
- **Android Studio** (ou outro editor compatível, como VS Code): Usado para editar o código e rodar o emulador Android.

## Passos para Configuração

### 1. Clonar o Repositório

Abra seu terminal e clone o repositório para sua máquina local:

```sh
git clone https://github.com/CIATEC-senac/controle-frotas-mobile.git
cd app-mobile
```

### 2. Instalar Dependências

Após navegar para o diretório do projeto, instale as dependências do Flutter:

```sh
flutter pub get
```

### 3. Verificar o Ambiente de Desenvolvimento

Para garantir que o ambiente de desenvolvimento Flutter está configurado corretamente, execute o comando:

```sh
flutter doctor
```

Certifique-se de resolver quaisquer problemas apontados pelo `flutter doctor` antes de continuar.

### 4. Executar o Projeto

Após configurar o emulador ou conectar um dispositivo, execute o projeto com o comando:

```sh
flutter run
```

## Comandos Úteis

- **Atualizar Dependências:** Execute `flutter pub get` sempre que adicionar novas dependências ao `pubspec.yaml`.

- **Build para Produção:**
  - **Android:** `flutter build apk`
