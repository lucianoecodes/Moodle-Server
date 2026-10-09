# 13. Passo a Passo — Implementação de um Novo Servidor

> Este guia descreve o passo a passo para **reproduzir uma nova implementação** deste servidor Moodle **do zero**, seguindo a mesma arquitetura.
>
> 🛠️ Execute sempre como **root** (ou via `sudo`).

## Fluxo Geral

```
1. Provisionar VM
2. Instalar Oracle Linux 9 (LVM)
3. Configurar rede / hostname / DNS / firewall
4. Instalar Docker + Docker Compose
5. Criar a stack Moodle
6. Instalar certificado e ativar HTTPS
7. Configurar o config.php
8. Personalizações pós-instalação
9. Validação final
```

---

## 13.1. Provisionamento da Máquina Virtual

- Criar a VM no **VMware** com:
  - **1 vCPU**
  - **8 GB de RAM**
  - **4 GB de swap**
- **Discos:**
  - 1º disco (`sda`) — **50 GB** para o SO;
  - 2º disco (`sdb`) — **100 GB** para dados (`/var`) do Docker.
- Configurar a rede para o IP desejado na mesma VLAN (ex.: `192.168.10.x/24`).

---

## 13.2. Instalação do Oracle Linux 9

- Instalar a ISO do **Oracle Linux Server 9.x** (modo **Server**, idioma `pt_BR`/`EN`).
- No **particionamento**, configurar LVM:
  - `vg_sistema` (root + swap) no `sda`;
  - `vg_dados-var` no `sdb`, montado em `/var`.
- Criar o **usuário administrativo** (ex.: `adminlocal`) e definir a senha do `root`.
- Após o boot, atualizar o sistema:

```bash
dnf update -y && dnf upgrade -y
```

---

## 13.3. Configuração de Rede, Hostname e DNS

```bash
# Definir o hostname
hostnamectl set-hostname serverlocal
```

- Configurar **IP estático** em `ens34`, gateway e DNS (`192.168.10.2` / `192.168.10.3`).
- Registrar no **DNS interno** o FQDN: `learning.test.local` → IP do servidor.
- Liberar no **firewall** (`firewall-cmd`) as portas `22`, `80` e `443`.

```bash
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload
```

---

## 13.4. Instalação do Docker e Docker Compose

Instalar o **Docker** (repo oficial):

```bash
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

- Habilitar e iniciar:

```bash
systemctl enable --now docker
```

- Verificar:

```bash
docker --version
docker compose version
```

---

## 13.5. Criação da Stack Moodle (Docker Compose)

```bash
# Criar o diretório da stack
mkdir -p /var/lib/docker/moodle-app
```

- Criar o arquivo **`docker-compose.yml`** com os serviços `database` (mariadb:10.11) e `moodle` (elestio/moodle:latest), conforme a [seção 7](07-stack-moodle.md).
- Criar as pastas persistentes:

```bash
mkdir -p /var/lib/docker/moodle-app/{ssl,apache2-sites,apache2-sites-enabled,apache2-mods}
```

- Subir a stack e conferir status:

```bash
docker compose up -d
docker ps
```

> 💡 Veja um exemplo em [`deploy/docker-compose.yml`](../deploy/docker-compose.yml).

---

## 13.6. Instalação do Certificado e Ativação do HTTPS

- Copiar o **certificado wildcard** (bundle `.pem` e `.key`) para `/var/lib/docker/moodle-app/ssl/`.
- Criar os vhosts `moodle-ssl.conf` (443) e `redirect-https.conf` (80) na pasta `apache2-sites/`.
- Criar os **symlinks** em `apache2-sites-enabled/` apontando para `/etc/apache2/sites-available/`.
- Criar a pasta `apache2-mods/` com **todos os módulos baseline** + `ssl.load`, `ssl.conf` e `socache_shmcb.load` (necessário para o `mod_ssl`).
- Atualizar o `docker-compose.yml` com os **bind mounts** e `MOODLE_URL=https://learning.test.local`.
- Recriar a stack:

```bash
docker compose up -d
```

- Testar:

```bash
curl -sI https://localhost/
openssl s_client -connect localhost:443 -servername learning.test.local
```

> ## ⚠️ IMPORTANTE
>
> Sem os bind mounts de `apache2-sites/` e `apache2-mods/`, o **mod_ssl não é habilitado** e o Apache entra em **crash-loop**:
>
> ```
> Invalid command 'SSLProtocol'
> ```

---

## 13.7. Configuração do config.php do Moodle

- Garantir o `wwwroot`:

```php
$CFG->wwwroot = 'https://learning.test.local';
```

- Garantir o `sslproxy`:

```php
$CFG->sslproxy = true;
```

- Limpar o cache:

```bash
docker exec -u www-data moodle-app-moodle-1 php /var/www/html/admin/cli/purge_caches.php
```

> ⚠️ O `config.php` fica em `/var/www/html/config.php` (volume `moodle_data`). Edite-o com cuidado (usar `docker cp` + copiar de volta evita corrompê-lo).

---

## 13.8. Personalizações Pós-Instalação

- **Login do Moodle**: remover a div `.login-layout-left-content` via HTML adicional (CSS `display:none`).
- **Idioma padrão**: definir `pt_br`; desativar **'Language autodetect'** (Platform de idioma) para não puxar o inglês do navegador.
- **Reset de senha do admin** (caso esqueça):

```bash
docker exec -it moodle-app-moodle-1 php /var/www/html/admin/cli/reset_password.php
```

- Configurar **LDAP** (grupos `GR-M-DEP-*`), **conclusão de curso** e **papéis** (líder/tutor) conforme o projeto.

---

## 13.9. Validação Final

- Acessar `https://learning.test.local` e confirmar o **cadeado válido**.
- Testar o redirect `http://` → `https://` (deve redirecionar automaticamente).
- Testar a persistência:

```bash
docker compose restart moodle
```

- Confirmar que **HTTPS continua de pé** após o restart.
- Fazer **backup completo** (volumes + pasta `/var/lib/docker/moodle-app/`) após a primeira configuração.

---

## Continuar

- [Anterior: Backup e Manutenção](12-backup-manutencao.md)
- [Voltar ao índice](../README.md)
