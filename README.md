# Nmap NSE web_techno

Detect web technology base on [wappalyer](https://github.com/AliasIO/wappalyzer)

## Installation

Need npm and jq

```bash
sudo npm install -g wappalyzer
sudo pacman -S jq
sudo cp web_techno.nse /usr/share/nmap/scripts/web_techno.nse
sudo nmap --script-updatedb
```

## Usage

```bash
nmap --script web_techno github.com
```

### output:

##### Github:

```
PORT    STATE SERVICE
80/tcp  open  http
| web_techno: 
|_  Redirection to: https://github.com/
443/tcp open  https
| web_techno: 
|   [CRM] Salesforce:unknow
|   [Web frameworks] Ruby on Rails:unknow
|   [PaaS] Amazon Web Services:unknow
|   [PaaS] GitHub Pages:unknow
|   [Webmail] Google Workspace:unknow
|   [Email] Google Workspace:unknow
|_  [SSL/TLS certificate authorities] DigiCert:unknow
```

##### Arch wiki:

```
PORT    STATE SERVICE
443/tcp open  https
| web_techno: 
|   [Wikis] MediaWiki:1.34.0
|   [Web servers] Nginx:1.16.1
|   [Reverse proxies] Nginx:1.16.1
|_  [Programming languages] PHP:7.4.4
```

##### Use `-sV` with non standards ports

Exemple:
--------

```bash
nmap --script web_techno  localhost
...
PORT      STATE SERVICE
22/tcp    open  ssh
80/tcp    open  http
| web_techno:
|   [JavaScript graphics] D3:3.0.8
|   [Web servers] Nginx:1.16.1
|_  [Reverse proxies] Nginx:1.16.1
8000/tcp  open  http-alt
12345/tcp open  netbus
```

Now with `-sV`:

```bash
nmap -sV --script web_techno  localhost
PORT      STATE SERVICE VERSION
22/tcp    open  ssh     OpenSSH 8.2 (protocol 2.0)
80/tcp    open  http    nginx 1.16.1
|_http-server-header: nginx/1.16.1
| web_techno:
|   [JavaScript graphics] D3:3.0.8
|   [Web servers] Nginx:1.16.1
|_  [Reverse proxies] Nginx:1.16.1
8000/tcp  open  http    SimpleHTTPServer 0.6 (Python 3.8.2)
|_http-server-header: SimpleHTTP/0.6 Python/3.8.2
| web_techno:
|   [Programming languages] Python:3.8.2
|_  [Web servers] SimpleHTTP:0.6
12345/tcp open  http    SimpleHTTPServer 0.6 (Python 3.8.2)
|_http-server-header: SimpleHTTP/0.6 Python/3.8.2
| web_techno:
|   [JavaScript graphics] D3:3.0.8
|   [Programming languages] Python:3.8.2
|_  [Web servers] SimpleHTTP:0.6
```

## TODO:

- Link cve to founded techno 
- Exploit cve
