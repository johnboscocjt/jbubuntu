# Performance Tuning Notes

CPU governor, process priority, thermal, and memory management on this system.

## auto-cpufreq

Automatic CPU frequency scaling for battery/performance balance.

| Item | Value |
|------|-------|
| Install path | `/opt/auto-cpufreq` |
| Service | `auto-cpufreq.service` |
| Unit file | `config/system-services/performance/auto-cpufreq.service` |

### Install

```bash
sudo chmod +x config/system-services/performance/auto-cpufreq-install.sh
sudo ./config/system-services/performance/auto-cpufreq-install.sh
```

Primary repo: `johnboscocjt/CPU-Autofrequency-Debian` (falls back to upstream `AdnanHodzic/auto-cpufreq`).

### Verify

```bash
systemctl status auto-cpufreq
sudo /opt/auto-cpufreq/venv/bin/auto-cpufreq --stats
```

### Troubleshooting

- Conflicts with `intel_pstate` / `amd_pstate` — see auto-cpufreq docs for kernel params
- Disable conflicting tools: TLP, system76-power (if duplicate governor control)

## ananicy-cpp

Process priority profiles (gaming, browsers, build tools).

```bash
sudo systemctl enable --now ananicy-cpp.service
```

Rules typically in `/etc/ananicy.d/` or package defaults.

## thermald

Intel thermal daemon — prevents throttling on laptops.

```bash
sudo systemctl enable --now thermald
```

## haveged

Userspace entropy source for faster `/dev/random` on VMs.

```bash
sudo systemctl enable --now haveged
```

## systemd-oomd

Out-of-memory killer with cgroup awareness (Ubuntu default on recent releases).

```bash
systemctl status systemd-oomd
```

Adjust `/etc/systemd/oomd.conf` if apps killed too aggressively.

## gamemode

Feral GameMode — request performance mode for games.

```bash
gamemoderun ./game
# or: __NV_PRIME_RENDER_OFFLOAD=1 gamemoderun ...
```

User service, not always a systemd unit.

## CPU frequency tools (manual)

```bash
cpupower frequency-info
sudo auto-cpufreq --force=governor=performance   # temporary
```

## Monitoring

GNOME extensions: **Astra Monitor**, **Vitals** — see `config/dconf/shell-extensions-settings/`.

CLI: `htop`, `fastfetch`, `missioncenter` (Flatpak).

## Recommended enable order

1. Install auto-cpufreq → enable service
2. Enable ananicy-cpp, thermald, haveged
3. Verify no duplicate governor (TLP vs auto-cpufreq)
4. Log reboot and check `systemctl status auto-cpufreq ananicy-cpp`

## Related

- [../enable-services.sh](../enable-services.sh)
- [../../docs/system-services-and-databases.md](../../docs/system-services-and-databases.md)
- [../maintenance/timers.md](../maintenance/timers.md)
