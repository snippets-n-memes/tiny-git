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
