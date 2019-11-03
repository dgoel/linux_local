Docker
------

# Setup docker

Follow the setup instructions on this page:

https://docs.docker.com/install/linux/docker-ce/ubuntu/

# Configure

https://docs.docker.com/config/daemon/systemd/#runtime-directory-and-storage-driver


## Runtime directory and storage driver

You may want to control the disk space used for Docker images, containers, and
volumes by moving it to a separate partition. To accomplish this, set the
following flags in the `etc/docker/daemon.json` file:

NOTE: don't put trailing `,` at the last entry of the json file, otherwise json
parsing may fail. Validate the json using https://jsonlint.com/
```json
{
    "data-root": "/mnt/docker-data",
    "storage-driver": "overlay2"
}
```

# Cheatsheet

