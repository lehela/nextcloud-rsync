## Goocloud CLI Client
> Nextcloud's own CLI client is not available on ARM.

Solution is to mount a users' Goocloud home directory as a WebDAV filesystem using `davfs2` into a container directory `/mnt/webdav`.
When that's done, we can `rsync` from a local directory mounted inside the container to the WebDAV folder.

> The tricky bit is that the container needs to keep running for a long period of time after the rsync command finishes. Apparently the actual file exchange between the container and the Goocloud server takes much longer to complete in the background.

To create the goocloud-rsync client image, run
````shell
./build.sh
````
You will be asked for a user, and password with which to connect to the Goocloud. 

Once the image has been build, running the rsync looks like this:
````shell
./exec.sh leif ~/Downloads test/ --progress
````

