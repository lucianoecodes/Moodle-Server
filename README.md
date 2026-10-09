# 🎓 Moodle Server — Documentação Técnica

> Infraestrutura do LMS **Moodle (Security Awareness)** 

Repositório com a documentação técnica completa do servidor que hospeda o Moodle da equipe de treinamento, incluindo a stack Docker, configuração HTTPS, banco de dados e o passo a passo para reproduzir uma nova implementação do zero.

| | |
|---|---|
| 🌐 **Domínio** | `https://learning.test.local` |
| 🖥️ **Servidor** | `serverlocal` (Oracle Linux 9.8) |
| 📦 **IP** | `192.168.10.5` |
| 🐳 **Docker** | Engine 29.8.0 · Compose v5.5.1 |
| 🗄️ **Moodle** | `elestio/moodle:latest` (5.2.x) + MariaDB 10.11 |

---

## 📑 Índice da Documentação

| # | Tópico | Documento |
|---|--------|-----------|
| 1 | Visão Geral do Servidor | [`docs/01-visao-geral.md`](docs/01-visao-geral.md) |
| 2 | Sistema Operacional | [`docs/02-sistema-operacional.md`](docs/02-sistema-operacional.md) |
| 3 | Discos e Partições (LVM + XFS) | [`docs/03-discos-particoes.md`](docs/03-discos-particoes.md) |
| 4 | Hardware e Desempenho | [`docs/04-hardware.md`](docs/04-hardware.md) |
| 5 | Rede (IP / DNS / Portas / Firewall) | [`docs/05-rede.md`](docs/05-rede.md) |
| 6 | Docker (Versões, Containers, Volumes) | [`docs/06-docker.md`](docs/06-docker.md) |
| 7 | Stack Moodle (Compose + Bind Mounts HTTPS) | [`docs/07-stack-moodle.md`](docs/07-stack-moodle.md) |
| 8 | Configuração HTTPS / Certificado | [`docs/08-https-certificado.md`](docs/08-https-certificado.md) |
| 9 | Banco de Dados | [`docs/09-banco-dados.md`](docs/09-banco-dados.md) |
| 10 | Usuários e Credenciais ⚠️ | [`docs/10-credenciais.md`](docs/10-credenciais.md) |
| 11 | Usuários do Sistema Operacional | [`docs/11-usuarios-sistema.md`](docs/11-usuarios-sistema.md) |
| 12 | Backup e Recomendações de Manutenção | [`docs/12-backup-manutencao.md`](docs/12-backup-manutencao.md) |
| 13 | Passo a Passo — Nova Implementação | [`docs/13-implementacao-novo-servidor.md`](docs/13-implementacao-novo-servidor.md) |

---

## 🗂️ Estrutura do Repositório

```
moodle-server-docs/
├── README.md                      ← Esta página (índice)
├── docs/                          ← Documentação técnica (markdown)
│   ├── 01-visao-geral.md
│   ├── 02-sistema-operacional.md
│   ├── ...                        ← (uma página por seção)
│   └── 13-implementacao-novo-servidor.md
├── deploy/
│   └── docker-compose.yml         ← Compose file (exemplo sanitizado)
├── config/
│   ├── moodle-ssl.conf            ← VirtualHost HTTPS (443)
│   ├── redirect-https.conf        ← Redirecionamento HTTP → HTTPS
│   └── config.php.example         ← Configuração do config.php do Moodle
└── scripts/
    └── backup.sh                  ← Script de backup sugerido
```

---

## 🚀 Reprodução Rápida (Resumo)

Uma nova implementação do servidor segue esta ordem:

1. **Provisionar a VM** (VMware: 1 vCPU, 8 GB RAM, 2 discos LVM).
2. **Instalar Oracle Linux 9** com LVM (`vg_sistema` + `vg_dados-var`).
3. **Configurar rede/ hostname/ DNS/ firewall** (portas 22, 80, 443).
4. **Instalar Docker + Compose** e criar a stack no `/var/lib/docker/moodle-app`.
5. **Instalar o certificado** wildcard `*.local.com` e ativar HTTPS.
6. **Ajustar o `config.php`** (wwwroot + sslproxy) e limpar o cache.
7. **Personalizações pós-instalação** (login, idioma, LDAP, papéis).
8. **Validar** o HTTPS, o redirect e a persistência.

> 📖 Detalhes completos de cada etapa em [`docs/13-implementacao-novo-servidor.md`](docs/13-implementacao-novo-servidor.md).

---

## ⚠️ Segurança e Acesso

O documento **[`docs/10-credenciais.md`](docs/10-credenciais.md)** contém caminhos de arquivos e credenciais.

- 🔐 As senhas aparecem em **texto claro** (padrão combinado no projeto).

---

## 📝 Manutenção

- Use um arquivo Markdown por seção para facilitar as atualizações.
- Mantenha o índice do `README.md` sincronizado com novos arquivos em `docs/`.
- Atualize o passo a passo (seção 13) sempre que a arquitetura mudar.

---

