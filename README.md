## Docker

### Dockerfile

`ENTRYPOINT` vs `CMD` https://stackoverflow.com/a/34245657/985454

### CLI

```
--entrypoint string     Overwrite the default ENTRYPOINT of the image
--name string           Assign a name to the container
--rm                    Automatically remove the container when it exits
```

### Publishing

1. Make sure to be logged in
    ```
   docker login
    ```
2. Push
   ```
    npm run docker:push
   ```
