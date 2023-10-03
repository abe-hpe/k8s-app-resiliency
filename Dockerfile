FROM debian:buster
RUN apt update && \
      apt install -y curl && \
      curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
      chmod +x ./kubectl && \
      mv ./kubectl /usr/local/bin/kubectl
CMD for ns in $(kubectl get ns -l=hpe.com/resiliency=restart -o=jsonpath='{.items[*].metadata.name}');do kubectl rollout restart deploy -n $ns;kubectl rollout restart sts -n $ns;kubectl rollout restart ds -n $ns;done;exit 0
