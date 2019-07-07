# 
![Nedi logo](http://www.nedi.ch/wp-content/uploads/nedi-dgray-320.jpg)


*** Launch of The BETA :D *

Version 0.95
Changelog.


Please be patient ........
***************************


Nedi

NeDi unfolds its full potential with CDP, FDP and/or LLDP capable devices in the core of your network. It can also include other network components, but it works best, when those are located at the network perimeter.

Nedi is developed and maintained by NeDi Consulting, released under the GPL v3 license


Network tools

NeDi discovers your network devices and tracks connected end-nodes. It contains many additional features for managing enterprise networks:
*    Intelligent topology awareness
*   MAC address mapping/tracking
*   Traffic, error, discard and broadcast graphing with threshold based alerting
*    Uptime, BGP peer and interface status monitoring
*    Correlate syslog messages and traps with discovery events
*    Network maps for documentation and monitoring dashboards
*    Detecti rouge access points and find missing devices
*    Extensive reporting ranging from devices, modules, interfaces all the way to assets and nodes 

Learn more on Nedi homepage www.nedi.ch


## How to use this Docker image

### Mysql

Run a MySQL database, dedicated to phpipam

```bash
$ docker run --name network-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -v /docker/network-mysql:/var/lib/mysql -d mysql:5.6
```
Here, we store data on the host system under `/network-mysql` ( don't forget to create this folder )  and use a specific root password. 

### Nedi

```bash
$ docker run -ti -d -p 514:514 -p 80:80 --name nedi --link network-mysql:mysql klinnex/nedi
```
### Configuration 

* Browse to `https://<ip>[:<specific_port>]/`

**** TO BE WRITE ****

### Docker compose 

You can create an all-in-one YAML deployment descriptor with Docker compose, like this : 
```yaml
version: '2'
services:
  network-mysql:
    image: mysql:5.6
    environment:
      - MYSQL_ROOT_PASSWORD=Password-Mysql
    restart: always
    volumes:
      - /docker/mysql:/var/lib/mysql
  nedi:
    depends_on:
      - network-mysql
    image: klinnex/nedi
    environment:
      - MYSQL_ENV_MYSQL_ROOT_PASSWORD=Password-Mysql
    volumes:
      - /docker/nedi:/var/nedi
    ports:
      - "80:80"
      - "514:514"
```
And next :

```bash 
$ docker-compose up -d
```

### Notes

