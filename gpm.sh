version: "3"

services:
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - prometheus-data:/prometheus
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    depends_on:
      - grafana
    # extra_hosts:
    #   - "host.docker.internal:host-gateway"

  grafana:
    image: grafana/grafana:latest
    volumes:
      - ./grafana.ini:/etc/grafana/grafana.ini
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    depends_on:
      - db

  db:
    image: mysql:latest
    restart: always
    environment:
      MYSQL_DATABASE: 'grafana-mysql'
      MYSQL_ROOT_PASSWORD: 'grafana-mysql'
    ports:
      - '3306:3306'
    volumes:
      - ./grafana-mysql:/var/lib/mysql


volumes:
  prometheus-data:
    driver: local

