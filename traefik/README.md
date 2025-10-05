# Example file providers
## Generic
Traefik is configured to use multiple separate files for the file provider. I suggest to use a single `YML` or `TOML` file per service.

You can use Go Templating to dynamically manipulate the files. This is particularly useful to access environment variables. I strongly recommend you to use `{{env "PROXY_DOMAIN"}}` to refer to your main domain name for the router.

## Synology Disk Station
[nas.yml](examples/nas.yml) can be used to proxy Synology DSM (tested on version 6). It includes logic to properly route mail an photo station to the webstation url (must be used in combination with [webstation.yml](webstation.yml)).

## Synology Web Station
[webstation.yml](examples/webstation.yml) can be used to proxy Synology Webstation (webserver on your nas).

## Home Assistant
[homeassistant.yml](examples/homeassistant.yml) can be used to proxy Home Assistant. In order for Home Assistant to accept the proxy, add the IP address of the server running Traefik to `configuraton.yaml` (Please see [documentation](https://www.home-assistant.io/docs/configuration/)):
```yml
# ...
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - # Insert IP address of server
```

## Proxmox Virtual Environment
[pve.yml](examples/pve.yml) can be used to proxy Proxmox VE.