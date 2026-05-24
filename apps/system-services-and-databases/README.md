# System Services & Databases

Enabled systemd units, database/web stack services, and performance tuning daemons on this workstation.

**Manifests:** [`config/system-services/enabled-services.txt`](../../config/system-services/enabled-services.txt) (78 units) · [`config/system-services/databases/manifest.json`](../../config/system-services/databases/manifest.json)

> Service **configs** are backed up (sanitized). Database **data directories** are not — migrate separately.

---

## Database & web stack services

| Name | Service unit | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **MariaDB** | `mariadb.service` | APT | MySQL-compatible SQL server | Laravel/MySQL projects | `systemctl restart mariadb`, import dumps |
| **PostgreSQL 18** | `postgresql.service` | APT | PostgreSQL database server | Apps requiring Postgres | `pg_ctlcluster`, manage `postgresql@18-main` |
| **Redis** | `redis-server.service` | APT | In-memory cache/queue | Laravel cache, sessions | `redis-cli ping`, monitor memory |
| **MongoDB** | `mongod.service` | APT | Document database daemon | NoSQL workloads | Fix permissions if failed on boot |
| **Apache2** | `apache2.service` | APT | HTTP web server | Local PHP sites | `systemctl reload apache2`, enable vhosts |
| **PHP-FPM 8.3** | `php8.3-fpm.service` | APT | PHP FastCGI pool (8.3) | Primary PHP for web | Restart after `php.ini` edits |
| **PHP-FPM 8.4** | `php8.4-fpm.service` | APT | Secondary PHP pool | Version-specific projects | Point vhost to 8.4 socket |

**Last known status:** MariaDB, PostgreSQL, Redis, Apache2, PHP 8.3-FPM active; MongoDB enabled but failed — verify on restore.

See [databases-and-backend/README.md](../databases-and-backend/README.md) for GUI admin tools.

---

## CPU, power & performance tuning

| Name | Service / path | Source | What it is | Used for | Typical tasks |
|------|----------------|--------|------------|----------|---------------|
| **auto-cpufreq** | `auto-cpufreq.service` → `/opt/auto-cpufreq/` | Manual install | Automatic CPU governor scaling | Balance battery vs performance | Tune governor profiles, view logs |
| **ananicy-cpp** | `ananicy-cpp.service` | APT / GitHub | Process priority scheduler | Keep desktop responsive under load | Assign nice levels to heavy builds |
| **thermald** | `thermald.service` | APT | Intel thermal daemon | Prevent CPU overheating/throttling | Monitor thermal zones |
| **systemd-oomd** | `systemd-oomd.service` | systemd | Out-of-memory killer | Protect system when RAM exhausted | Kill runaway processes before freeze |
| **gamemode** | (daemon via APT package) | APT | Performance mode for apps | Boost games and heavy workloads | Auto-trigger for supported apps |
| **haveged** | `haveged.service` | APT | Entropy daemon | Faster random for crypto ops | Improve `/dev/random` throughput |

**Related:** [`config/system-services/performance/auto-cpufreq.service`](../../config/system-services/performance/auto-cpufreq.service)

---

## Networking & security services

| Name | Service unit | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **NetworkManager** | `NetworkManager.service` | systemd/Ubuntu | Network connection manager | WiFi, Ethernet, VPN profiles | Connect to networks, save credentials |
| **UFW** | `ufw.service` | APT | Uncomplicated Firewall | Host firewall rules | `ufw enable`, allow SSH/HTTP |
| **OpenVPN** | `openvpn.service` | APT | VPN tunnel daemon | Custom VPN profiles | Start client tunnels |
| **Proton Split Tunnel** | `me.proton.vpn.split_tunneling.service` | Proton VPN | Per-app VPN routing | Exclude local dev from VPN | Configure split tunnel list |
| **AnyDesk** | `anydesk.service` | AnyDesk `.deb` | Remote desktop daemon | Unattended remote support | Allow incoming AnyDesk sessions |
| **Avahi** | `avahi-daemon.service` | APT | mDNS/DNS-SD | `.local` hostname discovery | Find printers/devices on LAN |
| **create_ap + dnsmasq** | `create_ap.service`, `dnsmasq.service` | APT | WiFi hotspot stack | Share internet as AP | Start hotspot for phone/laptop |
| **OpenSSH** | `sshd-keygen.service` | APT | SSH host key generation | Remote shell access | Enable `ssh.socket` if needed |
| **wpa_supplicant** | `wpa_supplicant.service` | APT | WiFi supplicant | WPA/WPA2/WPA3 association | Connect to encrypted WiFi |

---

## Virtualization & VM tools

| Name | Service unit | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **QEMU/KVM** | `qemu-kvm.service` | APT | KVM virtualization | Run VMs for testing | Start libvirt/QEMU guests |
| **open-vm-tools** | `open-vm-tools.service` | APT | VMware guest tools | Clipboard/sync in VMware VMs | Better VM integration |
| **vgauth** | `vgauth.service` | VMware | VM auth service | vSphere guest authentication | VMware environment only |

---

## Maintenance & updates

| Name | Service unit | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **cron** | `cron.service` | APT | Scheduled task runner | Timed scripts and jobs | Edit `crontab -e` |
| **anacron** | `anacron.service` | APT | Delayed periodic jobs | Run daily jobs if PC was off | Laptop-friendly scheduling |
| **unattended-upgrades** | `unattended-upgrades.service` | APT | Automatic security updates | Patch system without manual apt | Review `/var/log/unattended-upgrades` |
| **apport** | `apport.service` | Ubuntu | Crash report collector | Ubuntu error reporting | Submit crash reports |
| **kerneloops** | `kerneloops.service` | APT | Kernel oops reporter | Log kernel errors | Debug driver issues |
| **Canonical Livepatch** | `snap.canonical-livepatch.canonical-livepatchd.service` | Snap | Kernel live patching | Security fixes without reboot | `sudo canonical-livepatch status` |
| **fwupd-refresh** | timer | APT | Firmware update checks | Periodic hardware firmware scan | `fwupdmgr get-updates` |
| **sysstat** | `sysstat.service` | APT | Performance statistics | sar/iostat historical data | Analyze CPU trends |

---

## Desktop integration services

| Name | Service unit | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **Bluetooth** | `bluetooth.service` | APT | Bluetooth stack | Headphones, mice, phone pairing | `bluetoothctl connect` |
| **CUPS** | `cups.service`, `cups-browsed.service` | APT | Printing system | Network/local printers | Add printer, print PDFs |
| **snapd** | `snapd.service` + helpers | APT | Snap daemon | Snap app lifecycle | Refresh snaps, debug snap mounts |
| **accounts-daemon** | `accounts-daemon.service` | systemd | User account info | GNOME online accounts | Google/Microsoft sign-in |
| **udisks2** | `udisks2.service` | APT | Removable disk mounting | USB drives, automount | Plug in external SSD |

---

## Restore workflow

```bash
# Enable services from manifest (setup.sh --with-services)
while read -r svc; do
  sudo systemctl enable "$svc"
  sudo systemctl start "$svc" || echo "WARN: $svc failed"
done < config/system-services/enabled-services.txt

# Install auto-cpufreq from bundled script or CPU-Autofrequency-Debian repo
bash config/system-services/performance/auto-cpufreq-install.sh

# Health check
systemctl is-active mariadb postgresql redis-server mongod apache2 php8.3-fpm
```

Use `--skip-services` during setup if you want packages only without starting daemons.

---

## Not backed up

- Database data under `/var/lib/postgresql/`, `/var/lib/mysql/`, `/var/lib/mongodb/`, `/var/lib/redis/`
- Apache document roots with project code
- OpenVPN `.ovpn` files with embedded credentials
- UFW rules with machine-specific IP allowlists
- Proton VPN account session data
