**Documentação de implantação**

* Autora: Lara Silva Xavier
* [Github](https://github.com/Larasxavier/LSX)


**PASSO 1**: Criação do stack de monitoramento.

Foi provisionada uma VM Linux no ambiente de cloud da Azure para instalação e configuração de uma implementação de Kubernetes (k8S) da SUSE chamada de K3s (https://k3s.io/). Para gerenciamento dessa estrutura de k8s, foi instalado e configurado o Rancher (https://www.rancher.com/) de forma a facilitar o processo de deploy e configuração. Apartir do Rancher, foi criado um namespace chamado zabbix para que fosse feito o deploy dos componentes da stack Zabbix na versão 6.0.23. Os seguintes recursos k8s foram utilizados:

* Daemonset: Para deploy do zabbix-agent
* StatefulSet: Para o deploy do mysql-server e o zabbix-server utilizado a imagem de container customizada acrescentando o driver odbc.
* Deployment: Para o deploy do zabbix-web na versão nginx.
* Secrets: Para armazenamento de todos os dados sensíveis (usuários, senhas e etc) da stack.
* Configmap: Para armazenamento de todas as varíaveis de ambiente da stack.
* Ingress: Para externalizar o serviço do zabbix-web. 

**PASSO 2**: Monitoração de Serviço específico no Zabbix.

Uma vez que o agente zabbix foi instalado, basta criar um usuário mysql para criar a conexão entre banco e server através do agente,  aplicar o template "MySQL by Zabbix agent" e alterar as Macros do host/Instância que está sendo monitorada com as informações de usuário e senha da base que eles passarão a coletar. Não utilizei o driver ODBC para poder contemplar uma das facilidades que o agente propõe. Mas, se tratando de driver ODBC, a criação do script item pode se desenvolver de forma que ele atenderá ao tipo de item Monitoração de Banco de Dados e com todas as macros de conexão e caminho do driver preenchidas no host e referenciadas no item por motivos de segurança, haverá um espaço de pesquisa SQL para criação de um script Item. 

**PASSO 3**: Monitoramento da API Pokemon com descoberta

Foi criado o host pokeapi.co e criado o item de consulta utilizando a macro do host, após isso, criei um template apenas para realizar a descoberta e criação do prototype itens. 

**PASSO 4**: Monitoramento de Apache do webservice

4)  Teste a disponibilidade do http_stub_status_module nginx, e aplique o template "Nginx by Zabbix agent" no host. Nesse caso, decidi monitorar o frontend zabbix

**PASSO 5**: Processo XYZ

Baseado no entendimneto que a monitoração precisa partir de uma necessidade de trazer evidências sobre partes do processo que possam comprometer a finalidade e desempenho deste processo. Sendo assim buscaria entender junto ao cliente qual o objetivo do monitoramento e coletaria quais os principais indicadores KPI. Por exemplo: 
Compras finalizadas por minuto, taxa de erros de processamento na compra ou pagamento, tempo médio de resposta ou transações por segundo, crescimento de vendas, satisfação dos clientes.
Logo, será o primeiro passo para execução. 
1. Entender o objetivo da monitoração 
2. Conhecer arquitetura de organização da aplicação.
3. Identificar o que pode ser monitorado. Quais métricas serão coletadas (Recursos, serviços)
4. Definir gatilhos para alertas (Quando é um problema?)
5. Implementação no ambiente
6. Testagem

Entregáveis e Prazos.

• Plano de monitoramento descrevendo os indicadores-chave de desempenho, juntamente com os recursos necessários para implantação (pré-requisitos);

• Métricas a serem coletadas;

• Alertas a serem configurados.

Relatório de teste: Documentando os resultados do teste de monitoramento, e por fim, a documentação para o usuário descrevendo como utilizar o monitoramento (entendimento das métricas alertadas e dashboards, se for o caso).

O prazo da demanda vai depender principalmente da complexidade do processo e esforço da equipe para entendimento do processo e ambiente, já que não tem nenhuma documentação. Se os solicitantes auxiliarem no processo, ele pode ser mais rápido. 
Se tivesse a documentação sugeriria um prazo de 2 a 4 semanas pra monitoramento básico, como essa condição está em falta, daria um prazo factível de 4 a 8 semanas pelo esforço de coleta através de logs e entrevistas. 

**PASSO 6**: Monitoração de aplicação responsável por gerar vendas de tickets do metrô de SP.

Inicialmente, trabalharia no objetivo da monitoração, entender o gargalo do cliente é crucial. Após isso entenderia a infraestrutura que essa aplicação se encontra, banco de dados, frontend e backend juntos? Separados? Host físico, container, kubernetes?
Pensaria em uma monitoração de KPI e Infraestrutura, uma vez que o mau gerenciamento de recursos prejudica o desempenho da aplicação diretamente. Como por exemplo, a disponibilidade, performance e uso dos recursos (Infraestrutura) correlacionando com o tempo de resposta, taxa de erros, número de vendas (KPI). 
Infraestrutura realizaria o monitoramento básico (CPU, RAM, PING, rede, Load Average) inicialmente e buscaria a documentação da aplicação, se não estiver disponível partiria para uma análise mais técnica entrevistando o cliente e leitura de logs. 
Diante dos recursos da aplicação, pode-se pensar em:

Frontend:
Tempo de respostas das páginas
Erros
URLs acessadas

Backend:
Erros de integração com as catracas
Erros de envio de informações para o banco de dados
Tempo de processamento para compras
Tempo de processamento dos pagamentos

Banco de Dados:
Erros de consulta
Erros de gravação
Uso de recursos

Implementação do monitoramento 
Instrumentaria a partir do Opentelemetry diante da possibilidade de exportação das métricas coletadas para as outras citadas (Datadog, APM e Stack Grafana). 
1) Criando o diretório /opt/otel
2) Salvar o agente do opentelemtry no diretório
3) Configurar permissões de acesso ao diretório
4) Instrumentar inicialização da JVM com a flag
5) Se utilizar systemd para subir o serviço, efetue o override para definir variáveis de ambiente (Atenção: Caso já exista esse arquivo de override.conf, adicionar apenas o conteúdo abaixo da linha "[Service]")
6) Efetuar um daemon-reload no systemd
7) Caso utilize outro método para subir o serviço da aplicação defina algumas variáveis.
Testes e entrega. 
Sugestões: Teste de carga e podendo se estruturar engenharia do caos definindo hipóteses  de redundância, seleção de falhas, erros de processamento, ações automáticas.
