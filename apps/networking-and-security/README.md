# Networking & Security

VPN clients, packet analysis, penetration-testing utilities, WiFi tools, and remote access software.

**Related services:** [`config/system-services/enabled-services.txt`](../../config/system-services/enabled-services.txt) (`openvpn`, `anydesk`, `ufw`, Proton split tunneling)

---

## VPN

| Name | Package / Service | Source | What it is | Used for | Typical tasks |
|------|-------------------|--------|------------|----------|---------------|
| **Proton VPN** | `proton-vpn-gnome-desktop`, `protonvpn-stable-release` | APT ([Proton repo](../../data/apt-third-party.sh)) | Official Proton VPN GNOME client | Encrypted internet access, privacy on untrusted networks | Connect to country servers, enable kill switch, split tunneling |
| **Proton Split Tunneling** | `me.proton.vpn.split_tunneling.service` | systemd (Snap/Proton) | Routes selected apps outside VPN | Keep local dev servers reachable while VPN is on | Exclude Docker, localhost, or specific apps from tunnel |
| **OpenVPN** | `openvpn`, `openvpn.service` | APT | Open-source VPN protocol and client | Custom VPN profiles, corporate or self-hosted VPNs | Import `.ovpn` profiles, `systemctl start openvpn` |

> OpenVPN profile files with credentials are **not** backed up — restore manually after install.

---

## Network analysis

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Wireshark** | `wireshark`, `tshark` | APT | Packet capture and protocol analyzer | Debug network traffic, inspect HTTP/TLS/DNS | Capture on `wlan0`, filter by IP/port, follow TCP streams |
| **net-tools** | `net-tools` | APT | Classic networking utilities (`ifconfig`, `netstat`) | Legacy network diagnostics | Check interfaces, routing tables |
| **dnsutils** | `dnsutils` | APT | DNS lookup tools (`dig`, `nslookup`) | DNS troubleshooting | `dig example.com`, trace DNS resolution |
| **whois** | `whois` | APT | Domain and IP registration lookup | Recon on domains and IP blocks | `whois example.com` |
| **speedtest-cli** | `speedtest-cli` | APT | Command-line bandwidth test | Quick upload/download checks | `speedtest-cli --simple` |

---

## Penetration testing & recon

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **hashcat** | `hashcat` | APT | GPU-accelerated password cracker | Security audits, hash recovery (authorized testing only) | Crack WPA handshakes, test password policies |
| **reaver** | `reaver` | APT | WPS PIN brute-force tool | WiFi security assessment | Test WPS-enabled routers (lab/authorized only) |
| **wafw00f** | `wafw00f` | APT | Web Application Firewall fingerprinting | Identify WAF in front of web apps | `wafw00f https://target` |
| **whatweb** | `whatweb` | APT | Web technology fingerprinter | Discover CMS, frameworks, server headers | Scan sites for stack identification |
| **dnsrecon** | `dnsrecon` | APT | DNS enumeration tool | Subdomain and record discovery | Brute-force subdomains, zone transfers |
| **pixiewps** | `pixiewps` | APT | WPS offline attack helper | WiFi pentest workflows with reaver/hcxtools | Recover WPS PIN from captured data |
| **hcxtools** | `hcxtools` | APT | WiFi capture conversion utilities | Prepare captures for hashcat | Convert `.cap` to hashcat format |
| **hcxdumptool** | `hcxdumptool` | APT | WiFi capture tool | Collect WPA handshakes and PMKIDs | Monitor mode capture on compatible adapters |
| **macchanger** | `macchanger` | APT | MAC address spoofing | Privacy or lab network testing | Randomize interface MAC before scan |
| **crunch** | `crunch` | APT | Wordlist generator | Custom dictionary creation for audits | Generate pattern-based password lists |
| **steghide** | `steghide` | APT | Steganography tool | Hide/extract data in images/audio | Embed payloads in JPEG for CTF-style exercises |

---

## WiFi & hotspot

| Name | Package / Service | Source | What it is | Used for | Typical tasks |
|------|-------------------|--------|------------|----------|---------------|
| **create_ap** | `create_ap.service` | APT / manual | WiFi access point creator | Share internet or create isolated lab network | Start hotspot from Ethernet/WiFi |
| **dnsmasq** | `dnsmasq.service` | APT | Lightweight DNS/DHCP server | DHCP for hotspot clients | Assign IPs to connected devices |
| **hostapd** | `hostapd` | APT | WiFi access point daemon | Underlying AP for hotspot tools | Configure SSID and WPA for AP mode |
| **linux-wifi-hotspot** | (GUI wrapper) | APT / GitHub | User-friendly hotspot GUI | One-click hotspot without manual hostapd | Enable hotspot from system tray |
| **wireless-tools** | `wireless-tools` | APT | Legacy WiFi utilities (`iwconfig`) | Basic wireless interface control | Check link quality, ESSID |
| **rfkill** | `rfkill` | APT | Radio kill switch control | Enable/disable WiFi and Bluetooth radios | `rfkill list`, unblock WiFi |

---

## Remote access & firewall

| Name | Package / Service | Source | What it is | Used for | Typical tasks |
|------|-------------------|--------|------------|----------|---------------|
| **AnyDesk** | `anydesk`, `anydesk.service` | APT `.deb` | Remote desktop software | Support remote machines, screen sharing | Connect by ID, unattended access |
| **OpenSSH Server** | `openssh-server`, `sshd-keygen.service` | APT | Secure shell remote login | Remote terminal access to this PC or others | `ssh user@host`, key-based auth |
| **UFW** | `ufw.service` | APT | Uncomplicated Firewall | Inbound/outbound traffic rules | `ufw status`, allow ports 22/80/443 |
| **Remmina** | `remmina` | APT | Remote desktop client (RDP/VNC/SSH) | Connect to Windows/Linux remote desktops | Save connection profiles, RDP to VMs |

---

## Encryption & security utilities

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **VeraCrypt** | `veracrypt` | APT | Disk encryption software | Encrypted volumes for sensitive data | Mount encrypted containers, full-disk options |
| **GnuPG** | `gnupg`, `gpg`, `gpg-agent`, `dirmngr` | APT | OpenPGP encryption and signing | Signed git commits, encrypted files | `gpg --sign`, manage keyring |
| **ecryptfs-utils** | `ecryptfs-utils` | APT | Encrypted home directory utilities | Legacy eCryptfs home encryption | Encrypt user home (if configured) |

---

## QEMU / virtualization (network labs)

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **QEMU/KVM** | `qemu-kvm.service` | APT | Hardware virtualization | Isolated lab VMs for network testing | Run Kali/Windows VMs with bridged networking |

See also: [development/README.md](../development/README.md) for Packet Tracer network simulation.
