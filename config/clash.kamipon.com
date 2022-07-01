[http.routers]
  [http.routers.openwrt]
    entrypoints="https"
    rule="Host(`clash.kamipon.com`)"
    tls=true
    # middlewares=["error-pages-middleware@docker"]
    middlewares=["gzip@file"]
    service = "openwrt-service"

[http.services]
  [http.services.openwrt-service.loadBalancer]
    [[http.services.openwrt-service.loadBalancer.servers]]
      url = "http://10.99.1.1:9090/"
