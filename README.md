# MyFome

Este projeto tem como objetivo desenvolver a parte visual interativa de um sistema de catalogo de produtos chamado MyFome, a fim de simplificar o gerenciamento de lojas virtuais e inttroduzindo o micro e pequeno empresário no mercado digital. 

Ao decorrer das branches, você poderá observar a presença da arquitetural MVVM até metodologias de design e testes de software, a fim de construir um sistema simples e escalável.

Por fim, caso queira compartilhar sugestões sobre o projeto, entre em contato pelo e-mail: lazaroalexandre.dev@gmail.com ou crie uma nova issue.

## Inicialização

Primeiramente, instale todas as configurações do flutter em sua máquina, caso já não esteja instalada. Siga a documentação: https://docs.flutter.dev/get-started/install

Após a configuração, volte ao projeto e execute os seguintes comandos no terminal:

- Mude as variáveis de ambiente:
    - Faça uma cópia do arquivo .env.exemplo
    - Renomei o novo arquivo para .env
    - Adicione os dados corretos para cada variável de ambiente
    - Apague o arquivo lib/src/constants/env/env.g.dart

- Limpe, baixe e instale as dependências (Somente após o clone):
    - flutter clean
    - flutter pub get
    - cd uikit/
    - flutter pub get
    - cd ..
  
- Crie o build do gerenciamento de estado (Após o clone e em cada modificação do gerenciamento de estado):
    - dart run build_runner build

- Esolher o dispositivo (Durante a execução do sistema):
    - flutter devices

- Rodar o aplicativo (Durante a execução do sistema):
  - flutter run -d _nome_do_dispositivo_

## Autor

Olá, sou o Lázaro Alexandre, um desenvolvedor full stack e futuro analista de sistemas apaixonado por transformar vidas através da inovação tecnológica.

Para mais informações, acesse o meu portifólio: https://homolazarus.netlify.app/

Estarei te aguardando ^-^