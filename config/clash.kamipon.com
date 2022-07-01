[http.routers]
  [http.routers.clash]
    entrypoints="https"
    rule="Host(`clash.kamipon.com`)"
    tls=true
    # middlewares=["error-pages-middleware@docker"]
    middlewares=["gzip@file"]
    service = "clash-service"

[http.services]
  [http.services.clash-service.loadBalancer]
    [[http.services.clash-service.loadBalancer.servers]]
      url = "http://10.99.1.1:9090/"
