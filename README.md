# tiny-git
Docker image built from [git-scm instructions](https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server)

```sh
docker run -d -v $(pwd)/authorized_keys:/home/git/.ssh/authorized_keys tiny-git
```