# tiny-git
Docker image built from [git-scm instructions](https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server)

```sh
docker run -d -p 8888:22 tiny-git
```

- After creation you must copy your ssh public key to the authorized_keys file in /home/git/.ssh/authorized_keys
- .ssh directory and contained folders need to be owned by git user and have proper permissions
- /etc/ssh/sshd_config needs the correct path to the authorized keys file
- git user shell should be the git-shell
    - [change user shell in alpine](https://wiki.alpinelinux.org/wiki/Change_default_shell)


## Kube
Enable ssh tcp port for ingress-nginx
1. apply [configmap](./tcp-configmap.yaml)
1. point to configmap in ingress-nginx-controller deployment
    ```yaml
    spec:
      containers:
      - args:
        - /nginx-ingress-controller
        - --tcp-services-configmap=$(POD_NAMESPACE)/ingress-nginx-tcp
    ```
1. expose ssh port on ingress-nginx service
    ```yaml
    spec:
        ports:
        - name: 8080-tcp
            nodePort: 30957
            port: 8080
            protocol: TCP
            targetPort: 8080
    ```