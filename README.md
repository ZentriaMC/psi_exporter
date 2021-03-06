# psi_exporter

Prometheus exporter for [Pressure Stall Information] (PSI) from Linux kernel.

## Requirements

Kernel must support PSI (`CONFIG_PSI=y`), which requires at least Linux 4.20.

## Exported metric

The following metrics are exported:

```
$ curl -s http://ip6-localhost:12345/ | grep -E '(journald|^#)'
# HELP pressure_avg_10s_ratio Ratio of time spent under pressure in the last 10s at time of measurement
# TYPE pressure_avg_10s_ratio gauge
pressure_avg_10s_ratio{controller="cpu",id="/system.slice/systemd-journald.service",kind="some"} 0
pressure_avg_10s_ratio{controller="io",id="/system.slice/systemd-journald.service",kind="full"} 0
pressure_avg_10s_ratio{controller="io",id="/system.slice/systemd-journald.service",kind="some"} 0
pressure_avg_10s_ratio{controller="memory",id="/system.slice/systemd-journald.service",kind="full"} 0
pressure_avg_10s_ratio{controller="memory",id="/system.slice/systemd-journald.service",kind="some"} 0
# HELP pressure_avg_300s_ratio Ratio of time spent under pressure in the last 300s at time of measurement
# TYPE pressure_avg_300s_ratio gauge
pressure_avg_300s_ratio{controller="cpu",id="/system.slice/systemd-journald.service",kind="some"} 0
pressure_avg_300s_ratio{controller="io",id="/system.slice/systemd-journald.service",kind="full"} 0
pressure_avg_300s_ratio{controller="io",id="/system.slice/systemd-journald.service",kind="some"} 0
pressure_avg_300s_ratio{controller="memory",id="/system.slice/systemd-journald.service",kind="full"} 0
pressure_avg_300s_ratio{controller="memory",id="/system.slice/systemd-journald.service",kind="some"} 0
# HELP pressure_avg_60s_ratio Ratio of time spent under pressure in the last 60s at time of measurement
# TYPE pressure_avg_60s_ratio gauge
pressure_avg_60s_ratio{controller="cpu",id="/system.slice/systemd-journald.service",kind="some"} 0
pressure_avg_60s_ratio{controller="io",id="/system.slice/systemd-journald.service",kind="full"} 0
pressure_avg_60s_ratio{controller="io",id="/system.slice/systemd-journald.service",kind="some"} 0
pressure_avg_60s_ratio{controller="memory",id="/system.slice/systemd-journald.service",kind="full"} 0
pressure_avg_60s_ratio{controller="memory",id="/system.slice/systemd-journald.service",kind="some"} 0
# HELP pressure_total_seconds Total time spent under pressure
# TYPE pressure_total_seconds counter
pressure_total_seconds{controller="cpu",id="/system.slice/systemd-journald.service",kind="some"} 0.001546
pressure_total_seconds{controller="io",id="/system.slice/systemd-journald.service",kind="full"} 1.367656
pressure_total_seconds{controller="io",id="/system.slice/systemd-journald.service",kind="some"} 1.371462
pressure_total_seconds{controller="memory",id="/system.slice/systemd-journald.service",kind="full"} 0
pressure_total_seconds{controller="memory",id="/system.slice/systemd-journald.service",kind="some"} 0
```

## Usage

* `--metrics.disable-avg` disables reporting of averages.
* `--metrics.silence-zeros` silences reporting of zero values.

## Deploying

`docker run -d --name=psi-exporter -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 9100:9100 --privileged=true zentria/psi-exporter:latest`

Or using `docker-compose`:

```yaml
version: '2.4'

service:
  psi-exporter:
    image: zentria/psi-exporter:latest
    restart: unless-stopped
    privileged: true
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
```

## License

MIT

[Pressure Stall Information]: https://www.kernel.org/doc/html/latest/accounting/psi.html
