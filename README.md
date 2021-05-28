===== Read me // Relatório de entrega até 28/05 =====

Nome do projeto no Firebase: proj-manutencao
Plano no Firebase: Blaze (Hosting & Functions)
URL do projeto: https://console.firebase.google.com/u/0/project/proj-manutencao
URL do repositório: https://github.com/djowvani/firebase-test-project
URL da aplicação hosteada: https://proj-manutencao.web.app/
Versão do Node: v14.16.0

===== CLI Commands =====

npm install
firebase login -g firebase-tool
firebase deploy
npm run build
firebase deploy

firebase deploy --only hosting
(sobe apenas HTML novo)

npm run fixlint
(de acordo com as regras de linting desse projeto e sua versão do firebase)

firebase emulators:start
(sobe servidor local [rodar na pasta MenooFans])

===== Objetivos =====

- Deploy inicial da aplicação ✅
- Upload JSON inicial ✅ (database)
- Upload de images ✅ (database)
- Imagens dinâmicas
- Criação automatizada de documentos no Firebase

===== Dificuldades =====

- Script externo de injeção do JSON como documento no Firebase Store não foi a solução ideal ✅
- Identificar motivo pelo qual as rotas de restaurante /profile/[shortName] não estão funcionando ✅
- Identificar motivo pelo qual "menooItems" está vindo undefined
