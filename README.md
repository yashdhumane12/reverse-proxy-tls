# 🔒 Reverse Proxy + TLS — Nginx + HTTPS + Rate Limiting

Two apps behind Nginx with HTTPS (self-signed), host-based routing, path-based routing, and rate limiting.

## Quick Start
```bash
# Generate certs first
bash certs/generate.sh

# Start stack
docker compose up -d --build

# Add to /etc/hosts (Mac/Linux) or C:\Windows\System32\drivers\etc\hosts (Windows)
# 127.0.0.1 app1.local app2.local
```

## Routing modes

### Host-based (separate domains)
```bash
curl -k https://app1.local/    # → app-one
curl -k https://app2.local/    # → app-two
```

### Path-based (single domain)
```bash
curl -k https://localhost/api/v1/   # → app-one
curl -k https://localhost/api/v2/   # → app-two
```

### HTTP → HTTPS redirect
```bash
curl -v http://localhost/   # 301 → https://localhost/
```

## Test rate limiting
```bash
# Hit rate-limited endpoint 20 times fast
for i in $(seq 1 20); do curl -sk -o /dev/null -w "%{http_code}\n" https://localhost/rate-test; done
# You'll see 200s then 503s (rate limited)
```

## TLS verification
```bash
# See cert info
openssl s_client -connect localhost:443 -servername app1.local </dev/null 2>/dev/null | openssl x509 -noout -text

# Check TLS version
curl -v -k https://localhost/ 2>&1 | grep "SSL connection"
```

## Key learning
- TLS termination at Nginx — apps run plain HTTP internally
- SNI routing — different cert per hostname
- Rate limiting zones — per IP, shared memory
- HSTS header — forces HTTPS for 1 year
