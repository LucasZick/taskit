# Taskit

Uma aplicação Flutter para gerenciar tarefas.

## Pré-requisitos

Certifique-se de ter os seguintes softwares instalados:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [Git](https://git-scm.com)

## Instalação

1. Clone este repositório:
    ```sh
    git clone https://github.com/LucasZick/taskit.git
    ```

2. Navegue até o diretório do projeto:
    ```sh
    cd taskit
    ```

3. Instale as dependências do Flutter:
    ```sh
    flutter pub get
    ```

## Executando a Aplicação na Web

1. Certifique-se de que você possui os componentes web do Flutter instalados:
    ```sh
    flutter config --enable-web
    ```

2. Execute a aplicação na web:
    ```sh
    flutter run -d chrome
    ```

## Build para Produção

1. Gere o build para web:
    ```sh
    flutter build web
    ```

2. O build estará disponível no diretório `build/web`.
