# SEGLAB01
Laboratório 01 - Testando o conceito de orquestração com Terraform + AWS 

# Segurança em relação a Object Storage

No uso de S3 ou soluções similares, existe o conceito de Object Storage, isto é: Um modelo de armazenamento onde os dados são manipulados como objetos;

## Object Storage Policys

Conforme descrito no capítulo sobre autorização e autenticação, no uso de soluções baseadas em Cloud Computing temos o conceito de Policys,  a partir de uma policy é possível liberar o acesso à uma conta para um objetvo específico, como adicionar ou visualizar objetvos em um Bucket (nome dado aos diretórios criados para armazenar objetos).

Com base neste conceito a conta utilizada para este laboratório possui as seguintes premicias:


- Neste exemplo a conta foi criada no formato "Programatic Account", uma conta usada para administração via API e sem acesso ao painél de gestão, essa escolha de tipo de conta visa restringir o vetor de ataque;

- Esta conta será manipulada pelo terraform, que foi a solução de orquestração adotada no exemplo;

- O terraform foi configurado para guardar o estado dos recursos manipulados (criação de instancias, Elastic IPs etc.) em um bucket usando como mecanismo de autenticação a nossa "Programatic Account" e como mecanismo de autorização uma Policy de acesso ao Bucket similar a policy deste exemplo;

- A autorização nas policys se baseia na identifcação das contas que no caso da AWS são chamadas de  (ARNs) ou Amazon Resource Names;