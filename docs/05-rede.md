# 5. Rede (IP / DNS / Portas / Firewall)

## Configuração de rede

| Item | Valor |
|------|-------|
| **Interface** | `ens34` = `192.168.10.5/24` |
| **Gateway** | `192.168.10.1` |
| **DNS 1** | `192.168.10.2` |
| **DNS 2** | `192.168.10.3` |
| **Domínio (DNS)** | `learning.test.local` → `192.168.10.5` |

## Portas abertas

| Porta | Protocolo | Serviço | Descrição |
|-------|-----------|---------|-----------|
| `22/tcp` | SSH | `sshd` | Acesso administrativo |
| `80/tcp` | HTTP | `docker-proxy` | Redireciona para HTTPS |
| `443/tcp` | HTTPS | `docker-proxy` | Acesso ao Moodle |

> As portas 80 e 443 são expostas pelo container `moodle-app-moodle-1` via `docker-proxy`.

## Firewall

As portas `22`, `80` e `443` devem estar liberadas no firewall do SO (`firewall-cmd`).

```bash
# Liberar as portas no firewall (exemplo Oracle Linux)
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload
```

## Continuar

- [Anterior: Hardware](04-hardware.md)
- [Próximo: Docker](06-docker.md)
