# System Maintenance Timers

Scheduled maintenance tasks enabled on the source Ubuntu system.

## systemd timers (inspect)

```bash
systemctl list-timers --all
systemctl status apt-daily.timer fwupd-refresh.timer
```

## Notable timers

| Timer / service | Purpose |
|---------------|---------|
| `anacron.service` | Run delayed cron jobs on laptops that aren't always on |
| `fwupd-refresh.timer` | Firmware update metadata refresh (LVFS) |
| `apt-daily.timer` | Automatic package list updates |
| `apt-daily-upgrade.timer` | Unattended security upgrades (if enabled) |
| `phpsessionclean.timer` | Purge old PHP session files |
| `fstrim.timer` | SSD TRIM on schedule |
| `logrotate.timer` | Rotate log files |
| `motd-news.timer` | Ubuntu news in motd |

## PHP session cleanup

```bash
systemctl status phpsessionclean.timer
cat /usr/lib/systemd/system/phpsessionclean.timer
```

Runs `phpsessionclean` — important when PHP-FPM 8.3/8.4 serve many sites.

## Firmware updates (fwupd)

```bash
fwupdmgr refresh
fwupdmgr get-updates
sudo fwupdmgr update
```

Timer: `fwupd-refresh.timer`

## Canonical Livepatch (if subscribed)

Kernel live patching without reboot.

```bash
canonical-livepatch status
sudo pro status   # Ubuntu Pro
```

Not configured in repo — enable via Ubuntu Pro account if used.

## anacron

Ensures daily/weekly/monthly cron jobs run even when machine was off at scheduled time.

```bash
cat /etc/anacrontab
ls /etc/cron.{daily,weekly,monthly}/
```

## Manual maintenance checklist

```bash
# Weekly
sudo apt update && sudo apt upgrade
flatpak update
snap refresh

# Monthly
sudo apt autoremove --purge
docker system prune -f   # if using Docker
journalctl --disk-usage
sudo journalctl --vacuum-time=30d

# Database
sudo mysqlcheck --all-databases --auto-repair
sudo -u postgres vacuumdb --all --analyze
```

## Log rotation

```bash
cat /etc/logrotate.conf
ls /etc/logrotate.d/
```

Apache/PHP logs: `/var/log/apache2/`, `/var/log/php8.*-fpm.log`

## Related

- [../databases/RESTORE.md](../databases/RESTORE.md)
- [../performance/tuning-notes.md](../performance/tuning-notes.md)
- [../../docs/system-services-and-databases.md](../../docs/system-services-and-databases.md)
