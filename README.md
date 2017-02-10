# merijntjetak/es2graphite
This docker image runs the es2graphite data collector. es2graphite will get data from Elasticsearch and push it to graphite.

## Usage
Example usage:
```
docker run -e GRAPHITE_HOST=192.0.2.1 \
           -e GRAPHITE_PORT=2003 \
           -e ES_HOST=192.0.2.2 \
           merijntjetak/es2graphite
```

Options are set through environment variables, the following variables are available:

| Environment variable  | Description                                                     |
|-----------------------|-----------------------------------------------------------------|
| GRAPHITE_HOST         | Graphite host to connect to (default: localhost)                |
| GRAPHITE_PORT         | Graphite port to connect to (default: 2003)                     |
| ES_HOST               | Elasticsearch host to connect to (default: localhost)           |
| ES_PORT               | Elasticsearch port to connect to (default 9200)                 |
| PROTOCOL              | Graphite protocol to use (plaintext(default) or pickle)         |
| LOGLEVEL              | Logging level (debug, info, warn, error(default))               |
| HEALTHLEVEL           | Level of health metrics (cluster(default), indices, shards)     |
| INTERVAL              | Interval between polls (default: 60)                            |

## Development
The `make.sh` script is available for building, running and publishing the image. When using the script, make sure to update the variables in the top section.

## Ansible
The image can easily be deployed through Ansible. Use the following code snippet as an example to deploy the image:
```
- name: Start es2graphite
  docker_container:
    name: es2graphite
    state: started
    restart_policy: unless-stopped
    image: "merijntjetak/es2graphite"
    network_mode: host
    env:
      GRAPHITE_HOST: "{{ hostvars[groups['graphite'][0]]['ansible_eth0']['ipv4']['address'] }}"
      GRAPHITE_PORT: "{{ graphite_port }}"
      ES_HOST: "{{ hostvars[groups['elasticsearch'][0]]['ansible_eth0']['ipv4']['address'] }}"
      ES_PORT: "{{ elasticsearch_port }}"
```

## Acknowledgement
Development of this component was sponsored by Liberty Global B.V. (www.libertyglobal.com).
The es2graphite source can be found at: <https://github.com/mattweber/es2graphite>.
